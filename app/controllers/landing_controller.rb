#coding: utf-8
class LandingController < ApplicationController
  def index
    @tweets = Tweet.order("RAND()").first(3)
    render :layout => 'landing'
  end

  def subscribe
    @subscription = Subscription.new(email: params[:email])

    if @subscription.save
      Mailer.send_success_subscription(@subscription.email).deliver
      flash[:notice] = "Теперь вы подписаны на новости о HappyDev!"
    else
      flash[:error] = "Неверный формат email!"
    end

    redirect_to landing_path
  end
end
