# Load the Rails application.
require_relative 'application'

# load facebook secrets
#FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]

# Initialize the Rails application.
Rails.application.initialize!
