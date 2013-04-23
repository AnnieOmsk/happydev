module HttpAuthenticable
  USERNAME, PASSWORD = "earlybird", "a8d6e1cf0e253c60a98b846e2966bed7" 

  private
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == USERNAME && Digest::MD5.hexdigest(password) == PASSWORD
    end
  end 
end
