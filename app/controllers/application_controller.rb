class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def after_sign_in_path_for(user)
    root_path

    # if user.paid?
    #   root_path
    # else
    #   pay_path
    # end

  end
end
