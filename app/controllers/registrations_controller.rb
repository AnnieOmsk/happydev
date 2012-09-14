class RegistrationsController < Devise::RegistrationsController
  # hack for strange rails 3.2 production-only bug:
  ActionView::Base.field_error_proc = Proc.new{ |html_tag, instance| "<div class=\"field_with_errors\">#{html_tag}</div>".html_safe }

  def profile
    if current_user
      @invoice = current_user.invoice
    else
      redirect_to new_user_session_path
    end
  end
end
