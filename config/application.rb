require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RecipeCat
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # DEPRECATION WARNING: Time columns will become time zone aware in Rails 5.1.
    # This still causes `String`s to be parsed as if they were in `Time.zone`,
    # and `Time`s to be converted to `Time.zone`.
    # To keep the old behavior, you must add the following to your initializer:
    # config.active_record.time_zone_aware_types = [:datetime]
    # To silence this deprecation warning, add the following:
    config.active_record.time_zone_aware_types = [:datetime, :time]
  end
end
