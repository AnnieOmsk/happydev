module HttpAuthenticable
  USERNAME, PASSWORD = "ibragim", "e8193999646fd6ec6204c66c97005326" 

  private
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == USERNAME && Digest::MD5.hexdigest(password) == PASSWORD
    end
  end 
end
