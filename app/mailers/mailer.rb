# encoding: utf-8
class Mailer < Devise::Mailer
  # helper :application # gives access to all helpers defined within `application_helper`.
  default :from => "HappyDev <org@happydev.ru>"

  # Send notification on mail user
  def send_notification(*content)
    @user = User.find_by_email(content[0])
    mail(:to => content[0],
         :subject => "Мы зарегистрировали тебя на конференцию HappyDev")
  end

  def send_success_payment_notification(*content)
    @invoice = content[1]
    @user = User.find_by_email(content[0])
    mail(:to => content[0],
         :subject => 'Участие в конференции HappyDev оплачено. Спасибо!')
  end

  def send_choice_part_conf(*content)
    tmp = {}
    tmp[:events] = content[1]
    tmp[:amount] = content[2]
    tmp[:expired_at] = content[3]
    @content = tmp
    mail(:to => content[0],
         :subject => 'Твой заказ на конференцию HappyDev')
  end

  def send_success_subscription(email)
    attachments.inline['logo.png'] = File.read("#{Rails.root.to_s + '/app/assets/images/blocks/b-logo/HD13.png'}")
    attachments.inline['vk.png'] = File.read("#{Rails.root.to_s + '/app/assets/images/sites-icons/vk.png'}")
    attachments.inline['fb.png'] = File.read("#{Rails.root.to_s + '/app/assets/images/sites-icons/facebook.png'}")
    attachments.inline['tw.png'] = File.read("#{Rails.root.to_s + '/app/assets/images/sites-icons/twitter.png'}")
    @user = User.find_by_email(email)
    mail(:to => email,
         :subject => "Подписка на новости HappyDev'13")
  end

end
