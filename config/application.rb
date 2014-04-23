require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Pienkowski
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Warsaw'

    config.i18n.fallbacks = [:en]
    config.i18n.default_locale = :pl

    config.action_controller.include_all_helpers = false

    config.assets.precompile += %w( layouts/guest.css layouts/guest.js )
    config.assets.precompile << ->(path) do
      if path =~ /^\w+(\/\w+)*\.(css|js)$/
        path.sub(/\.(css|js)$/, '_controller').camelize.constantize <= ApplicationController rescue false
      else
        false
      end
    end
  end
end
