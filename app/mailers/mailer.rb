# encoding: utf-8
class Mailer < Devise::Mailer
  # helper :application # gives access to all helpers defined within `application_helper`.
  default :from => "org@happydev.ru"

  # Send notification on mail user
  def send_notification(*content)
    mail(:to => content[0],
         :subject => "Привет от HappyDev")
  end

end