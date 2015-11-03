# Load the Rails application.
require File.expand_path('../application', __FILE__)

# For the mailer to work.
config.action_mailer.default_url_options = { :host => 'scdp.heroku.com' }

# Initialize the Rails application.
Rails.application.initialize!
