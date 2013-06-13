redis = YAML.load_file("#{Rails.root.to_s}/config/config.yml")[Rails.env]['redis']

# PASSWORD_REQUIRED = %w(production staging)
PASSWORD_REQUIRED = []

Sidekiq.configure_server do |config|
  config.redis = { :url => "redis://#{':' + redis['password'] if PASSWORD_REQUIRED.include?(Rails.env)}@#{redis['host']}:#{redis['port']}/#{redis['db']}", :namespace => Rails.env }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => "redis://#{':' + redis['password'] if PASSWORD_REQUIRED.include?(Rails.env)}@#{redis['host']}:#{redis['port']}/#{redis['db']}", :namespace => Rails.env, :size => 1 }
end

Sidekiq::Mailer.excluded_environments = [:test]
