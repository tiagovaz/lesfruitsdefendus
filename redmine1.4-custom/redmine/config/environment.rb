# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
ENV['RAILS_ENV'] ||= 'production'

# for debian package : setup proper environment variables and paths
# To run redmine as unprivileged user, see /usr/share/doc/redmine/README.Debian
ObjectSpace.each_object(Thin::Runner){|x| ENV["X_DEBIAN_SITEID"] = x.options[:x_debian_siteid] if x.options[:x_debian_siteid]} if defined?(Thin)
ENV['X_DEBIAN_SITEID'] ||= 'default'
ENV['RAILS_ETC'] ||= "/etc/redmine/#{ENV['X_DEBIAN_SITEID']}"
ENV['RAILS_LOG'] ||= "/var/log/redmine/#{ENV['X_DEBIAN_SITEID']}"
ENV['RAILS_VAR'] ||= "/var/lib/redmine/#{ENV['X_DEBIAN_SITEID']}"
ENV['RAILS_CACHE'] ||= "/var/cache/redmine/#{ENV['X_DEBIAN_SITEID']}"
ENV['SCHEMA'] ||= "#{ENV['RAILS_CACHE']}/schema.db"

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

if RUBY_VERSION >= '1.9' && defined?(Rails) && Rails::VERSION::MAJOR < 3
  Encoding.default_external = 'UTF-8'
end

# loads cookie based session session and secret keys
# this is needed here because initializers are loaded after plugins,
# and some plugins initialize ActionController which requires a secret to be set.
# crash if file not found
filename = ENV['RAILS_ETC'] ? File.join(ENV['RAILS_ETC'], 'session.yml') : File.join(File.dirname(__FILE__), '..', 'session.yml')
sessionconfig = YAML::load_file(filename)
require 'action_controller'
relativeUrlRoot = ENV['RAILS_RELATIVE_URL_ROOT']
ActionController::Base.session = {
  :key => sessionconfig[Rails.env]['key'],
  :secret => sessionconfig[Rails.env]['secret'],
  :path => (relativeUrlRoot.blank?) ? '/' : relativeUrlRoot
}

# Load Engine plugin if available
begin
  require File.join(File.dirname(__FILE__), '../vendor/plugins/engines/boot')
  Engines::public_directory = "#{ENV['RAILS_CACHE']}/plugin_assets"
rescue LoadError
  # Not available
end

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence those specified here

  # Skip frameworks you're not going to use
  # config.frameworks -= [ :action_web_service, :action_mailer ]

  # Add additional load paths for sweepers
  config.autoload_paths += %W( #{RAILS_ROOT}/app/sweepers )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # log path
  config.log_path = File.join(ENV['RAILS_LOG'], "#{ENV['RAILS_ENV']}.log") unless !ENV['RAILS_LOG']

  # Enable page/fragment caching by setting a file-based store
  # (remember to create the caching directory and make it readable to the application)
  # config.action_controller.cache_store = :file_store, "#{RAILS_ROOT}/tmp/cache"

  config.cache_store = :file_store, ENV['RAILS_CACHE']
  
  # Set Active Record's database.yml path
  config.database_configuration_file = File.join(ENV['RAILS_ETC'], 'database.yml') unless !ENV['RAILS_ETC']

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  config.active_record.observers = :message_observer, :issue_observer, :journal_observer, :news_observer, :document_observer, :wiki_content_observer, :comment_observer

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc

  # Use Active Record's schema dumper instead of SQL when creating the test database
  # (enables use of different database adapters for development and test environments)
  # config.active_record.schema_format = :ruby

  # Deliveries are disabled by default. Do NOT modify this section.
  # Define your email configuration in configuration.yml instead.
  # It will automatically turn deliveries on
  config.action_mailer.perform_deliveries = false

  # Load any local configuration that is kept out of source control
  # (e.g. gems, patches).
  if File.exists?(File.join(File.dirname(__FILE__), 'additional_environment.rb'))
    instance_eval File.read(File.join(File.dirname(__FILE__), 'additional_environment.rb'))
  end
end
