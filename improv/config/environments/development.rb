Improv::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  # For ActiveAdmin
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # For Devise OmniAuth
  #
  # For Ed's machine:
  # TOKEN: 250634021702621
  # SECRET: 5132fb812f464e4a2c300fb5c20db10d
  #
  # config.facebook_token = ENV["DEV_FACEBOOK_TOKEN"]
  # config.facebook_secret = ENV["DEV_FACEBOOK_SECRET"]
  config.facebook_token = "250634021702621"
  config.facebook_secret = "5132fb812f464e4a2c300fb5c20db10d"
  config.twitter_token = ENV["DEV_TWITTER_TOKEN"]
  config.twitter_secret = ENV["DEV_TWITTER_SECRET"]
end
