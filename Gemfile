source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# payments
gem 'stripe'
gem 'paypal-recurring'
gem 'rest-client'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use mysql as the database for Active Record
gem 'mysql2'
gem 'uuid'
gem 'dalli'

gem 'devise'
gem 'geocoder'
gem 'useragent'

#gem 'omniauth-openid', :git => 'git://github.com/intridea/omniauth-openid.git'
gem 'mini_magick'
gem 'carrierwave'

gem 'simple_form', '~> 3.0.0.rc'
gem 'haml-rails'
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails', '~> 2.2.8'
gem 'kaminari' #pagination plugin

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '4.1.0', :require => false
  gem 'fakeweb', :require => false
  gem 'webmock'
  gem 'simplecov-rcov'
  gem 'spork', '~> 1.0rc'
  gem 'faker', '1.0.1'
  gem 'shoulda-matchers'
  gem 'cucumber-rails', :require => false
end

group :development do
  # Use Capistrano for deployment
  gem 'capistrano'
  gem 'capistrano-ext'
end
