# Sidekiq configuration file, this isn't entirely necessary, but it's good to have here
# in case anyone needs to tune the sidekiq configuration
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end