# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # You have to specify the :lib option for libraries, where the Gem name (sqlite3-ruby) differs from the file itself (sqlite3)
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "haml"
  config.gem "RedCloth"
  # config.gem "memcache-client", :lib => "memcache"
  config.gem 'thoughtbot-paperclip', :lib => 'paperclip', :source => "http://gems.github.com"
  config.gem 'javan-whenever', :lib => false, :source => 'http://gems.github.com'

  if RAILS_ENV == 'test'
    config.gem 'mocha'
    config.gem 'assert2'
    config.gem 'iridesco-time-warp', :lib => 'time_warp', :source => "http://gems.github.com"
  end

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  config.time_zone = 'UTC'

  # The internationalization framework can be changed to have another default locale (standard is :en) or more load paths.
  # All files from config/locales/*.rb,yml are added automatically.
  # config.i18n.load_path << Dir[File.join(RAILS_ROOT, 'my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  session_secret =
    if RAILS_ENV == 'production'
      session_config_file = File.expand_path("#{RAILS_ROOT}/config/session.secret")
      unless File.exists?(session_config_file)
        fail "No config/session.secret found. Please create one with 'rake --silent secret > /path/to/app/shared/config/session.secret'"
      end
      File.open(session_config_file).read.strip
    else
      #the secret for development & test
      'de8792329704179c89ddfd66afbd19a1b0666398377e148696440a3e8d1ad8f6617b75dfd74cd4d633f241431594b577052071dc52a0747aba53849c323e7fd1'
    end

  config.action_controller.session = {
    :session_key => "_template_session#{'test' if RAILS_ENV == 'test'}",
    :secret      => session_secret
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # Please note that observers generated using script/generate observer need to have an _observer suffix
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
end

ExceptionNotifier.sender_address       = %("Template bug" <dummy@dummyemailaddress.com>)
ExceptionNotifier.exception_recipients = %w(dummy@dummyemailaddress.com dummy2@dummyemailaddress.com)
