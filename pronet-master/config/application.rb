require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pronet
  class Application < Rails::Application
    config.autoload_paths << "#{Rails.root}/lib"

    config.active_record.time_zone_aware_types = [:datetime, :time]
    config.active_record.schema_format = :sql
  end
end
