class RegistrationsController < Devise::RegistrationsController

  def profile
    if current_user
      @invoice = current_user.invoice
    else
      redirect_to new_user_session_path
    end
  end
end
