require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'dotenv' ; 

Dotenv.load ".env.local", ".env.#{Rails.env}"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Reservester
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.generators do |g| 
        g.test_framework :rspec, 
            :fixtures => true, 
            :view_specs => false, 
            :helper_specs => false, 
            :routing_specs => false, 
            :controller_specs => true, 
            :request_specs => true 
        g.fixture_replacement :factory_girl, :dir => "spec/factories" 

        if Rails.env.test? or Rails.env.cucumber?
              CarrierWave.configure do |config|
                    config.storage = :file
                    config.enable_processing = false
              end
        else
            CarrierWave.configure do |config|
                    config.storage = :fog
                    config.fog_credentials = {
                    :provider               => 'AWS',                        
                    :aws_access_key_id      => ENV['S3_SECRET_KEY_ID'],
                    :aws_secret_access_key  => ENV['S3_SECRET_KEY'],
                }
                config.fog_directory  = ENV['S3_BUCKET']
                config.fog_public     = false
                config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
            end
        end
    end 
  end
end
