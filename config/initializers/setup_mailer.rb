ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "happydev.ru",
  :user_name            => "org@happydev.ru",
  :password             => "22yXFu9EwmgexFc",
  :authentication       => "plain",
  :enable_starttls_auto => true
}