# encoding: utf-8
class PaymentsController < ApplicationController
  include ActiveMerchant::Billing::Integrations

  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!, :only => [:success, :fail]
  before_filter :create_notification, :only => [:success, :fail]


  # Робокасса вызывает этот метод после успешной оплаты, перед тем, как отправить юзера на success url.
  # Запрос производится после получения робокассой денег.
  # Запрос верен, если:
  # 1) Контрольная сумма верна
  # 2) Сумма платежа равна запрошенной сумме
  # Если всё окей, робокассе отправляется успешный ответ.
  def result
    @notification = Robokassa::Notification.new(request.raw_post, :secret => APP_CONFIG['robokassa']['secret2'])

    if @notification.acknowledge
      @invoice = Invoice.find_by_code(@notification.item_id)

      if @invoice
        @invoice.payments.create(:amount => @notification.gross.to_i)
        @invoice.mark_invoice_events_paid
        # TODO: @invoice.mark_freeze!

        if @invoice.user
          Mailer.send_success_payment_notification(@invoice.user.email, @invoice).deliver!
        else
          logger.error "> Not found user for invoice: #{@notification.item_id}"
          head :bad_request
        end
      else
        logger.error "> Bad invoice: #{@notification.item_id}"
        head :bad_request
      end
    else
      head :bad_request
    end
  end

  # В случае успешного платежа покупатель переходит по этому адресу
  def success
    if @notification.acknowledge
      flash[:notice] = 'Оплата прошла успешно.'
      redirect_to invoice_path
    else
      head :bad_request
    end
  end
  
  # В случае отказа от исполнения платежа Покупатель перенаправляется по данному адресу
  def fail
    @invoice = current_user.invoice
    flash[:error] = 'Вы отменили оплату'
    redirect_to invoice_path
  end

  private
  def create_notification
    @notification = Robokassa::Notification.new(request.raw_post, :secret => APP_CONFIG['robokassa']['secret1'])
  end
end
