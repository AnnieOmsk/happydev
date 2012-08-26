# encoding: utf-8
class PaymentsController < ApplicationController
  include ActiveMerchant::Billing::Integrations

  skip_before_filter :verify_authenticity_token
  
  before_filter :authenticate_user!, :only => [:new, :create, :show]
  before_filter :create_notification, :only => [:success, :fail]
  before_filter :find_payment, :only => [:show, :result, :success, :fail]
  
  def new
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

  # Робокасса вызывает этот метод после успешной оплаты.
  # Нужно проверить правильность контрольной суммы и отправить робокассе, что все окей
  def result
    @notification = Robokassa::Notification.new(request.raw_post, :secret => 'bdjyygrygbvvhlg2012')
    if @notification.acknowledge
      render :text => @notification.success_response
    else
      head :bad_request
    end
  end

  # Robokassa redirect user to this action if it’s all ok
  def success
    if @notification.acknowledge && !@payment.paid
      @payment.approve!
      redirect_to payment_path, :notice => 'Success payment'  
    else
      head :bad_request
    end
  end

  # Robokassa redirect user to this action if it’s not
  def fail
    flash[:error] = 'Вы отменили оплату'
    redirect_to payment_path
  end
  
  def demopage
  end

  private

  def create_notification
    @notification = Robokassa::Notification.new(request.raw_post, :secret => 'dkhtdkjhpbkcp,2012')
  end

  def find_payment
    @payment = current_user.payment
  end
end
