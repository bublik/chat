source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'
gem 'devise'

# payments
gem 'stripe'
gem 'paypal-recurring'

# Use mysql as the database for Active Record
gem 'mysql2'
gem 'uuid'
gem 'dalli'
gem 'geocoder'


gem 'mini_magick'
gem 'carrierwave'
gem 'simple_form', '~> 3.0.0.rc'
gem 'haml-rails'
gem 'jbuilder', '~> 1.2'
gem 'twitter-bootstrap-rails', '~> 2.2.8'
gem 'kaminari' #pagination plugin
gem 'jquery-rails'

group :development do
  # Use Capistrano for deployment
  gem 'capistrano'
  gem 'capistrano-ext'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'fakeweb', :require => false
  gem 'webmock'
  gem 'vcr'
  gem 'simplecov-rcov'
  gem 'database_cleaner'
  gem 'spork', '~> 1.0rc'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 4.0.0'
  gem 'coffee-rails', '~> 4.0.0'
  gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem 'uglifier', '>= 1.3.0'
end


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
