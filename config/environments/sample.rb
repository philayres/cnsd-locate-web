CnsdLocateWeb::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  
  LocateServer = 'http://localhost:15501'
  LocateClientId = 'cnsd_locate_web_123yujy9812y38'
  LocateClientSecret = 'set-me'
  
  
  TwitterAccessToken ='76816072-zwEa6H3yUZX8k5RxchL8ldi5PzBPCcRVCasqFQHm0'
  TwitterAccessTokenSecret = 'set-me'
  TwitterConsumerKey = '4UhCiVNZfyD4KAPhcdeCgtAUd'
  TwitterConsumerKeySecret = 'set-me'
  
  GoogleMapsApiKey = 'set-me'
end
