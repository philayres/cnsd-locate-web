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
  LocateClientSecret = '78bf1cb75a5c62efa16b1s33c3e1205880add6d4fd4099e989bcf6223b7a40ca2'
  
  
  TwitterAccessToken ='76816072-zwEa6H3yUZeX8k5RxchL8ldi5PzBPCcRVCasqFQHm0'
  TwitterAccessTokenSecret = 'BEgasLfs2usfyWUuTmixIyd0qJ96heE1TmwUuQVbjz0rOm'
  TwitterConsumerKey = '4UhCiVNZfyDs4KAPhcdeCgtAUd'
  TwitterConsumerKeySecret = 'RCcUV3ZgrupVLH6Wv6HsGDYKRVyy0ztJWlL4YHDjby1oCHJDieO'
  
  GoogleMapsApiKey = 'AIzaSyCZw8PbLHPjSqmyCTFqRyd9ad-XjFUGMjs'
  
  
  AwsKey_CndsLocateWeb = 'AKIAIS43FGLOWS25XZMQ'
  AwsSecret_CndsLocateWeb = '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'

  config.action_mailer.default_url_options = { host: 'localhost', port: 5501 }
  config.action_mailer.mailgun_settings = {domain: 'app123example.mailgun.org', api_key: 'key-something'}
end
