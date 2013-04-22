class Mailchimp
  def initialize
    @hominid = Hominid::API.new(APP_CONFIG['mailchimp']['api_key'])
  end

  def subscribe_to_list(email, first_name, last_name = nil)
    names = {'FNAME' => first_name, 'LNAME' => last_name }.delete_if { |_, value| value.nil? }
    @hominid.list_subscribe(APP_CONFIG['mailchimp']['list_id'], email, names, 'html', false, true, true, false)
  rescue Hominid::APIError
    Rails.logger.fatal ">>> Mailchimp API Error while sending email to #{email}"
  end
  
  def subscribe_to_news(email, first_name = nil, last_name = nil)
    news_list_id = APP_CONFIG['mailchimp']['list_id_news']
    if news_list_id
      names = {'FNAME' => first_name, 'LNAME' => last_name }.delete_if { |_, value| value.nil? }
      @hominid.list_subscribe(news_list_id, email, names, 'html', false, true, true, false)
    end
  rescue Hominid::APIError
    Rails.logger.fatal ">>> Mailchimp API Error while sending email to #{email}"
  end
end
