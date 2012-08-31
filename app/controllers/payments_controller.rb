# encoding: utf-8
class PaymentsController < ApplicationController
  include ActiveMerchant::Billing::Integrations

  skip_before_filter :verify_authenticity_token
  before_filter :create_notification, :only => [:success, :fail]


  # Робокасса вызывает этот метод после успешной оплаты, перед тем, как вызвать success url.
  # Запрос производится после получения робокассой денег.
  # Запрос верен, если:
  # 1) Контрольная сумма верна
  # 2) Сумма платежа равна запрошенной сумме
  # Если всё окей, робокассе отправляется успешный ответ.
  def result
    @notification = Robokassa::Notification.new(request.raw_post, :secret => APP_CONFIG['robokassa']['secret2'])
    if @notification.acknowledge
      render :text => @notification.success_response
    else
      head :bad_request
    end
  end

  # В случае успешного платежа покупатель переходит по этому адресу
  # Если контрольная сумма верна и заказ ещё не помечен как оплаченный, то
  # обновляем payment в базе, ставя ему paid = true
  def success
    @invoice = current_user.invoice
    if @notification.acknowledge && !@invoice.all_invoice_events_paid?
      payment = @invoice.payments.create(:amount => @notification.gross.to_i)
      @invoice.check_invoice_events_paid
      Mailer.send_success_payment_notification(current_user.email, @invoice).deliver!
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
