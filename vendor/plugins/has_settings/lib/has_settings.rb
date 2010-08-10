module ActiveRecord
  module Has
    module Settings
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        def has_settings(options = {})
	    class_eval { cattr_accessor :nil_value }
	    self.nil_value = ([nil] << options[:nil_value]).flatten.uniq
	    serialize :settings
	    include ActiveRecord::Has::Settings::InstanceMethods
        end
      end

      module InstanceMethods
        def method_missing(method, *args)
	    begin
		super
	    rescue NoMethodError
		name = method.to_s
		self.settings = {} unless self.settings.is_a?(Hash)
		if name =~ /=$/
		    name.chomp!('=')
		    sym = name.to_sym
		    val = args.first
		    self.settings_will_change! if self.respond_to?(:settings_will_change!)
		    if self.nil_value.include? val #val.blank? or val == '0'
			self.settings[sym] = nil 
		    else
			self.settings[sym] = val
		    end
		else
                    val = self.settings[name.to_sym]
                    if RUBY_VERSION > '1.9' && val.respond_to?(:force_encoding)
                        val = val.force_encoding("UTF-8")
                    end
		    return val
		end
	    end
	end
      end
    end
  end
end
