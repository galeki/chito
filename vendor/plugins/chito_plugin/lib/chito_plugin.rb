class ChitoPlugin
    PLUGIN_PATH = File.expand_path("#{Rails.root}/vendor/plugins/chito_plugins")
    PUBLIC_PATH =  File.expand_path(File.join(Rails.root, "public/plugins"))    
    attr_accessor :id, :name, :version,
                  :writer, :web, :contributers,
                  :category, :info,
                  :no_config, :min_chito_version
    @@plugins = []
    @@plugins_has_config = nil

    def initialize(&block)
        instance_eval &block
    end

    def self.add(plugin)
        @@plugins << plugin
    end

    def self.plugins
        @@plugins
    end

    def self.plugins_has_config
        @@plugins_has_config ||= @@plugins.reject{|x| x.no_config}
        @@plugins_has_config
    end

    def self.file_path(plugin, file)
        File.join PLUGIN_PATH, plugin, "public", file
    end

    def self.copy_to_public(plugin)
        src = File.join(PLUGIN_PATH, plugin, "public")
        dst = File.join(PUBLIC_PATH, plugin)
        FileUtils.makedirs dst # rescue nil
        ['images', 'javascripts', 'stylesheets'].each do |f|
            if File.exists?(File.join(src, f))
                FileUtils.cp_r File.join(src, f), dst # rescue nil
            end
        end
    end

    def self.find(id)
        id ? ChitoPlugin.plugins_has_config.detect{|x| x.id == id} : ChitoPlugin.plugins_has_config.first
    end

    def i18n_name
        I18n.t :name, :scope => [:plugins, self.id.to_sym], :default => self.name
    end

end

I18n.load_path += Dir[ File.join(ChitoPlugin::PLUGIN_PATH, '*', 'locale', '*.{rb,yml}') ]

