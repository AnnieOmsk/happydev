# encoding: utf-8
class PaymentsController < ApplicationController
  include ActiveMerchant::Billing::Integrations

  skip_before_filter :verify_authenticity_token
  
  before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :create_notification, :only => [:success, :fail]
  before_filter :find_payment, :only => [:result, :success, :fail]
  
  def new
    @payment = current_user.build_payment
    @events = Event.all
  end

  def create
    @payment = current_user.build_payment(params[:payment])
    if @payment.save
      flash[:notice] = 'Иииииихааааааааа! сохранено'
    else
      flash[:notice] = 'Ошибка :('
    end
    redirect_to edit_user_registration_path
  end

  # Robokassa call this action after transaction
  def result
    @notification = Robokassa::Notification.new(request.raw_post, :secret => 'bdjyygrygbvvhlg2012')
    if @notification.acknowledge # check if it’s genuine Robokassa request
      # @payment.approve! # project-specific code
      redirect_to root_url, :notice => 'Success notification'  
    else
      head :bad_request
    end
  end

  # Robokassa redirect user to this action if it’s all ok
  def success
    if @notification.acknowledge
      redirect_to root_url, :notice => 'Success payment'  
    else
      head :bad_request
    end
    # if !@payment.approved? && @notification.acknowledge
    #   @payment.approve!
    # end

    # redirect_to @payment, :notice => I18n.t("notice.robokassa.success")
  end

  # Robokassa redirect user to this action if it’s not
  def fail
    flash[:error] = 'Failed request'
    redirect_to root_url
    # redirect_to @payment, :notice => I18n.t("notice.robokassa.fail")
  end
  
  def demopage
  end

  private

  def create_notification
    @notification = Robokassa::Notification.new(request.raw_post, :secret => 'dkhtdkjhpbkcp,2012')
  end

  def find_payment
    # @payment = Payment.find(@notification.item_id)
  end
end
