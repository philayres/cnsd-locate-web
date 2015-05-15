CnsdLocateWeb::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_assets  = true
  config.static_cache_control = "public, max-age=3600"

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  LocateServer = 'http://localhost:15501'
  LocateClientId = 'cnsd_locate_web_123yujy9812y38'
  LocateClientSecret = '78bf1cb75a5c62efa16b133c3e1205880add6d4fd4099e989bcf6223b7a40ca2'

  
  TwitterAccessToken ='76816072-zwEa6H3yUZX8k5RxchL8ldi5PzBPCcRVCasqFQHm0'
  TwitterAccessTokenSecret = 'BEgasLfs2usyWUuTmixIyd0qJ96heE1TmwUuQVbjz0rOm'
  TwitterConsumerKey = '4UhCiVNZfyD4KAPhcdeCgtAUd'
  TwitterConsumerKeySecret = 'RCcUV3ZgrupVLH6Wv6HsGDYKRVy0ztJWlL4YHDjby1oCHJDieO'
  
end
