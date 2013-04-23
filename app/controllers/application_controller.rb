class ApplicationController < ActionController::Base
  include HttpAuthenticable if Rails.env = 'staging'
  layout 'design_2.0'
  protect_from_forgery
  ensure_security_headers

  private
  def after_sign_in_path_for(user)
    # root_path

    if user.paid?
      root_path
    else
      pay_path
    end
  end

  def authenticate_admin!
    redirect_to '/' unless current_user && current_user.admin?
  end

  def move_to_register_if_not_signed_in
    redirect_to new_user_registration_path(:student => params[:student] || nil) unless current_user
  end
end
