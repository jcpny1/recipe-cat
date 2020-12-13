source 'https://rubygems.org'

ruby '~>2.7.2'            # Programming language version. This entry is for Heroku.

group :production do
  gem 'pg', '~> 1.0'      # Used as the database for Active Record.
end

gem 'mail', '~> 2.7.0'    # rails is pulling in mail 2.6.5. gemnasium says use 2.6.6 for security.
gem 'puma', '~> 3.11'     # Use Puma as the app server
gem 'rails', '~> 5.1'     # Full-stack web framework.

gem 'coffee-rails', '~> 4.2'  # Use CoffeeScript for .coffee assets and views
gem 'sass-rails', '~> 5.0'    # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'    # Use Uglifier as compressor for JavaScript assets
# gem 'therubyracer', platforms: :ruby  # See https://github.com/rails/execjs#readme for more supported runtimes

gem 'jquery-rails'          # Use jquery as the JavaScript library
gem 'turbolinks', '~> 5'    # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'jbuilder', '~> 2.5'  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'redis', '~> 3.0'     # Use Redis adapter to run Action Cable in production
# gem 'bcrypt', '~> 3.1.7'  # Use ActiveModel has_secure_password
# gem 'capistrano-rails', group: :development  # Use Capistrano for deployment

### Begin my additions ###
gem 'active_model_serializers', '~> 0.10.0'
gem 'bootstrap-sass', '~> 3.4.1'
gem 'devise'
gem 'dotenv-rails'  # Loads environment variables from `.env`.
gem 'omniauth-facebook'
gem 'omniauth-rails_csrf_protection', '~> 0.1'  # to address CVE-2015-9284.
gem 'pundit'
### End my additions   ###

group :development do
  gem 'listen'
  gem 'spring'                   # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
end

group :test do
  gem 'capybara'                # Needed for RSpec feature tests.
  gem 'database_cleaner'
  gem 'factory_bot_rails'       # Factory to Rails integration.
  gem 'codeclimate-test-reporter', '~> 1.0.0'
  gem 'rspec-rails', '~> 3.7'   # Rails testing framework.
  gem 'simplecov'               # Ruby code coverage analysis.
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]   # A Ruby debugger.
  gem 'pry'                                             # An IRB alternative runtime developer console.
  gem 'pry-byebug'                                      # Adds step-by-step debugging and stack navigation capabilities to pry using byebug. To use, invoke pry normally.
  gem 'rack_session_access'
  gem 'rails-controller-testing'
  gem 'sqlite3'                                         # Use sqlite3 as the database for Active Record
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
