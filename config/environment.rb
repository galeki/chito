# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = "2.0.2"
$KCODE = 'u'
require 'jcode' 
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
require "chito_helper"
require "chito_version"
Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence those specified here
  # Skip frameworks you're not going to use (only works if using vendor/rails)
   #config.frameworks -= [ :action_mailer ]

  #config.action_view.sanitized_allowed_tags = 'table', 'tr', 'td'
  #config.action_view.sanitized_allowed_attributes = 'id', 'class', 'style', 'align', 'border', 'margin', 'padding'
  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  #
   config.action_controller.session_store = :p_store
   #config.action_controller.session_store = :active_record_store

   config.action_controller.cache_store = :file_store, "#{RAILS_ROOT}/tmp/cache"
   #config.action_controller.fragment_cache_store = :file_store, "#{RAILS_ROOT}/tmp/cache"
   
   
   config.plugins = [ :chito_plugin, :all ]
   #config.action_controller.session_store = :memory_store
  config.load_paths += %W(
    vendor/redcloth/lib
    vendor/simple-rss/lib
    vendor/uuidtools/lib
    vendor/gettext/lib
  ).map {|dir| "#{RAILS_ROOT}/#{dir}"}.select { |dir| File.directory?(dir) } 
  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  #config.action_controller.session = {
  #  :session_key => '_chito_session',
  #  :secret      => 'cfb8733302e2533ca5d22b4cb72af032a56634a69fac916401f6b1cc21284743a0149bbbadf30d576ba02108c944cb6f59ab86e97768d0ce4273af0b1d7ca57a'
  #} 
  # See Rails::Configuration for more options
end
#ActionController::Base.fragment_cache_store = ActionController::Caching::Fragments::FileStore.new

Time::DATE_FORMATS[:db_short] = "%Y-%m-%d %H:%M"
Time::DATE_FORMATS[:update] = "<b>%H:%M</b>"


#ActionController::Base.session_options[:session_key] = "chito_session"
   
#require 'url_helper_patch'
#Mime::Type.register "application/pdf", :pdf
#require 'gettext/rails'
#require 'will_paginate'
#require 'pseudo_gettext'

#ActionMailer::Base.raise_delivery_errors = false
#ActionMailer::Base.default_charset = "utf-8"
#ROOT_DOMAIN = 'the-programmer.net'  
#ActionController::Base.session_options[:session_domain] = ROOT_DOMAIN  

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Include your application configuration below
