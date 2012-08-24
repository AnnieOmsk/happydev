class Mailchimp
  def initialize
    @hominid = Hominid::API.new(APP_CONFIG['mailchimp']['api_key'])
  end

  def subscribe_to_list(email)
    @hominid.list_subscribe(APP_CONFIG['mailchimp']['list_id'], email, {}, 'html', false, true, true, false)
  rescue Hominid::APIError
    Rails.logger.fatal ">>> Mailchimp API Error while sending email to #{email}"
  end
end
