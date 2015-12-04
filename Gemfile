source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
gem 'sidekiq' #Background job execution
gem 'bcrypt', '3.1.7'
gem 'bootstrap-sass', '3.2.0.0'
gem 'faker', '1.4.2'
gem 'will_paginate', '3.0.7'
gem 'bootstrap-will_paginate', '0.0.10'
# gem "compass-rails", "~> 2.0.alpha.0"
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'google_url_shortener' #pull stats from google/create new links
gem 'zeroclipboard-rails' #copy links to clipboard
gem 'link_thumbnailer'    #Get website thumbnails/flavicons/information
# Use jquery as the JavaScript library
gem 'jquery-rails', '4.0.3' #
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '2.5.3' #
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'compass-rails', '~> 2.0.4'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '1.3.10' #
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '5.0.0'#

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '1.3.6' #
end 
  
  group :production do 
    gem 'pg', '0.17.1' 
    gem 'rails_12factor', '0.0.2' 
    gem 'puma', '2.11.1'
  
end

