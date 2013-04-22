#coding:utf-8
class LandingController < ApplicationController
  def index
    render :layout => 'landing'
  end

  def subscribe
    email = params[:email]
    Mailchimp.new.subscribe_to_news(email)
    Mailer.send_success_subscription(email).deliver()
    flash[:notice] = "Теперь вы подписаны на новости о HappyDev!"
    redirect_to landing_path
  end
end
