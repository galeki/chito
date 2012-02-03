require File.expand_path('../boot', __FILE__)

require 'yaml'
CHITO_CONFIG = YAML.load(File.read(File.expand_path('../chito_config.yml', __FILE__)))

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Chito
  class Application < Rails::Application
    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    #config.autoload_paths += %W(#{Rails.root}/lib)
    #config.autoload_paths += %W(#{Rails.root}/app/sweepers)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    config.action_controller.cache_store = :file_store, "#{Rails.root}/tmp/cache"
    #config.action_controller.cache_store = :memory_store

    #config.plugin_paths = "#{Rails.root}/vendor/plugins/chito_plugins"
    #config.paths.vendor.plugins("vendor/plugins", "vendor/plugins/chito_plugins")
    config.paths["vendor/plugins"] = ["vendor/plugins", "vendor/plugins/chito_plugins"]
    config.plugins = [ :chito_plugin, :all ]
    #config.action_controller.session_store = :memory_store
    
    config.action_view.sanitized_allowed_tags = %w(u strong em b i p code pre sub sup cite small address br div span ul ol li dt dd abbr acronym img blockquote)
    config.action_view.sanitized_allowed_attributes = %w(src alt cite title class style id)
    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

  end
end

Time::DATE_FORMATS[:db_short] = "%Y-%m-%d %H:%M"
Time::DATE_FORMATS[:update] = "<b>%H:%M</b>"
