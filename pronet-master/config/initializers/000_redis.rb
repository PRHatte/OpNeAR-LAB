# Get the correct redis url
ENV['REDIS_URL'] = ENV['REDIS_URL'] || 'redis://localhost:6379'

# This is a lazy singleton, it won't create the connection until it's asked for.
class Redis
  def self.current
    @current ||= Redis.new(url: ENV['REDIS_URL'])
  end
end

# Proper usage of the above class is like so.
# 
# Redis.current.set("foo", "bar")