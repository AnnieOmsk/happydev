# encoding: utf-8
class Mailer < Devise::Mailer
  # helper :application # gives access to all helpers defined within `application_helper`.
  default :from => "HappyDev org@happydev.ru"

  # Send notification on mail user
  def send_notification(*content)
    mail(:to => content[0],
         :subject => "Мы зарегистрировали вас на конференицю HappyDev")
  end

  def send_success_payment_notification(*content)
    mail(:to => content[0],
         :subject => 'Успешный заказ!')
  end

end
