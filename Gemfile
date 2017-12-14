source 'https://rubygems.org'

ruby '~>2.4.2'                    # Programming language version. This entry is for Heroku.

group :production do
  gem 'pg', '~> 0.21.0'           # Used as the database for Active Record.
end

gem 'mail', '~> 2.7.0'            # rails is pulling in mail 2.6.5. gemnasium says use 2.6.6 for security.
gem 'puma', '~> 3.11'             # Use Puma as the app server
gem 'rails', '~> 5.1', '>= 5.1.4' # Full-stack web framework.

gem 'sass-rails', '~> 5.0'  # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'  # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.2'  # Use CoffeeScript for .coffee assets and views
# gem 'therubyracer', platforms: :ruby  # See https://github.com/rails/execjs#readme for more supported runtimes

gem 'jquery-rails'  # Use jquery as the JavaScript library
gem 'turbolinks', '~> 5'  # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'jbuilder', '~> 2.5'  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'redis', '~> 3.0'  # Use Redis adapter to run Action Cable in production
# gem 'bcrypt', '~> 3.1.7'  # Use ActiveModel has_secure_password
# gem 'capistrano-rails', group: :development  # Use Capistrano for deployment

### Begin my additions ###
gem 'active_model_serializers', '~> 0.10.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'devise'
gem 'dotenv-rails'  # Loads environment variables from `.env`.
gem 'omniauth-facebook'
gem 'pundit'
### End my additions   ###

group :development, :test do
  gem 'byebug', platform: :mri  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'pry-byebug'  # Adds step-by-step debugging and stack navigation capabilities to pry using byebug. To use, invoke pry normally.
  gem 'rack_session_access'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.5'
  gem 'sqlite3'  # Use sqlite3 as the database for Active Record
end

group :development do
  gem 'web-console', '>= 3.3.0'  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen'
  gem 'spring'  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov'
  gem 'codeclimate-test-reporter', '~> 1.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
