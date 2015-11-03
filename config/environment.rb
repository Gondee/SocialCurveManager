# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# For the mailer to work.
config.action_mailer.default_url_options = { :host => 'scdp.heroku.com' }