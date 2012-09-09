# encoding: utf-8
class PaymentsController < ApplicationController
  include ActiveMerchant::Billing::Integrations

  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!, :only => [:success, :fail]
  before_filter :create_notification, :only => [:success, :fail]


  # Робокасса вызывает этот метод после успешной оплаты, перед тем, как вызвать success url.
  # Запрос производится после получения робокассой денег.
  # Если всё окей, робокассе отправляется успешный ответ.
  def result
    @notification = Robokassa::Notification.new(request.raw_post, :secret => APP_CONFIG['robokassa']['secret2'])

    if @notification.acknowledge
      @invoice = Invoice.find_by_code(@notification.item_id)

      @invoice.payments.create(:amount => @notification.gross.to_i)
      @invoice.mark_invoice_events_paid
      # TODO: @invoice.mark_freeze!

      Mailer.send_success_payment_notification(@invoice.user.email, @invoice).deliver!
      render :text => @notification.success_response
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
