Airbrake.configure do |config|
  config.api_key     = '54cbd3f32d2a1dc4f861db888fba3b51'
  config.host        = '7bits.it'
  config.port        = 4001
  config.secure      = config.port == 443
  config.ignore_only = []
end