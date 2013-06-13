redis = YAML.load_file("#{Rails.root.to_s}/config/config.yml")[Rails.env]['redis']

# PASSWORD_REQUIRED = %w(production staging)

Sidekiq.configure_server do |config|
  config.redis = { :url => "redis://#{redis['host']}:#{redis['port']}/#{redis['db']}", :namespace => Rails.env }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => "redis://#{redis['host']}:#{redis['port']}/#{redis['db']}", :namespace => Rails.env, :size => 1 }
end

Sidekiq::Mailer.excluded_environments = [:test]