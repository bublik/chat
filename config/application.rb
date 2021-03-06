require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)
APP_CONFIG = YAML.load_file(File.expand_path('../config.yml', __FILE__))[Rails.env]

module Chat
  class Application < Rails::Application
    config.assets.paths << "#{Rails.root}/app/assets/fonts/"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.active_record.schema_format = :sql
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :ru

    config.filter_parameters += [:password, :password_confirmation]

    config.generators do |g|
      # g.orm :active_record
      g.template_engine :haml
      g.stylesheets false
      g.test_framework :rspec, views: false, fixture: true
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

  end
end
