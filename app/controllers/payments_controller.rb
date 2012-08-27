# encoding: utf-8
class PaymentsController < ApplicationController
  include ActiveMerchant::Billing::Integrations

  skip_before_filter :verify_authenticity_token
  
  before_filter :authenticate_user!, :only => [:new, :create, :show, :update_amount]
  before_filter :create_notification, :only => [:success, :fail]
  before_filter :find_payment, :only => [:show, :success, :fail, :update_amount]
 
  def new
    redirect_to payment_path if current_user.payment
    @payment = current_user.build_payment
    @events = Event.all
    gon.event_prices = @events.map { |e| [e.id, e.price] }
  end

  def create
    @payment = current_user.build_payment(params[:payment])
    if @payment.save
      flash[:notice] = "Заказ добавлен. Теперь вы можете оплатить его"
    else
      flash[:notice] = 'Ошибка при регистрации'
    end
    redirect_to payment_path
  end

  def show
  end

  # Робокасса вызывает этот метод после успешной оплаты, перед тем, как вызвать success url.
  # Запрос производится после получения робокассой денег.
  # Запрос верен, если:
  # 1) Контрольная сумма верна
  # 2) Сумма платежа равна запрошенной сумме
  # Если всё окей, робокассе отправляется успешный ответ.
  def result
    @notification = Robokassa::Notification.new(request.raw_post, :secret => 'bdjyygrygbvvhlg2012')
    @payment = Payment.find(@notification.item_id)
    if @notification.acknowledge && @notification.gross == @payment.expected_amount
      render :text => @notification.success_response
    else
      head :bad_request
    end
  end

  # В случае успешного платежа покупатель переходит по этому адресу
  # Если контрольная сумма верна и заказ ещё не помечен как оплаченный, то
  # обновляем payment в базе, ставя ему paid = true
  def success
    if @notification.acknowledge && !@payment.paid
      @payment.update_paid_amount!(@notification.gross)
      @payment.approve!
      redirect_to payment_path, :notice => 'Success payment'  
    else
      head :bad_request
    end
  end

  
  # В случае отказа от исполнения платежа Покупатель перенаправляется по данному адресу
  def fail
    flash[:error] = 'Вы отменили оплату'
    redirect_to payment_path
  end
  
  def demopage
  end

  def update_amount
    @payment.update_expected_amount!
    render :json => @payment
  end

  private

  def create_notification
    @notification = Robokassa::Notification.new(request.raw_post, :secret => 'dkhtdkjhpbkcp,2012')
  end

  def find_payment
    @payment = current_user.payment
  end
end
