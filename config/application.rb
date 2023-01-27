require_relative 'boot'

require 'rails/all'
require 'carrierwave'
require 'fog/core'
Fog::Logger[:deprecation] = nil

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AhleAuctionApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.time_zone = 'America/Chicago'
    config.beginning_of_week = :sunday

    config.action_mailer.preview_path = "#{Rails.root}/lib/mailer_previews"

    ActionMailer::Base.smtp_settings = {
        :user_name => ENV["GMAIL_UN"],
        :password => ENV["GMAIL_PW"],
        :address => 'smtp.gmail.com',
        :port => 587,
        :authentication => :plain,
        :enable_starttls_auto => true
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
