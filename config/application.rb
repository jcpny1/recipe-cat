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

    # From Heroku:
    # By default Rails 4 will not serve your assets.
    # To enable this functionality you need to go into config/application.rb and add this line:
    config.serve_static_assets = true

    # DEPRECATION WARNING: Leaving `ActiveRecord::ConnectionAdapters::SQLite3Adapter.represent_boolean_as_integer`
    # set to false is deprecated. SQLite databases have used 't' and 'f' to serialize
    # boolean values and must have old data converted to 1 and 0 (its native boolean
    # serialization) before setting this flag to true. Conversion can be accomplished
    # by setting up a rake task which runs
    #
    #   ExampleModel.where("boolean_column = 't'").update_all(boolean_column: 1)
    #   ExampleModel.where("boolean_column = 'f'").update_all(boolean_column: 0)
    #
    # for all models and all boolean columns, after which the flag must be set to
    # true by adding the following to your application.rb file:
    #
    # Rails.application.config.active_record.sqlite3.represent_boolean_as_integer = true
    config.active_record.sqlite3.represent_boolean_as_integer = true
  end
end
