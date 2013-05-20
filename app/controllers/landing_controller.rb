#coding: utf-8
class LandingController < ApplicationController
  def index
    @tweets = Tweet.order("RAND()").first(3)
    #@tweets = []
        #render :layout => 'landing'
    respond_to do |format|
      format.html   { render :layout => 'landing.html' }
      format.mobile { render :layout => 'landing.mobile' }
    end
  end

  def subscribe
    @subscription = Subscription.new(email: params[:email])
    response_json = {:success => true, :msg => "Теперь вы подписаны на новости о HappyDev!"}

    if @subscription.save
      Mailer.send_success_subscription(@subscription.email).deliver
      #flash[:notice] = "Теперь вы подписаны на новости о HappyDev!"
    else
      #flash[:error] = "Неверный формат email!"
      response_json = {:success => false, :error => "Неверный формат email!"}
    end

    #redirect_to landing_path
    render :json => response_json
  end
end
