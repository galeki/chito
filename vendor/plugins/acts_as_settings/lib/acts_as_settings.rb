module ActiveRecord
  module Acts
    module Settings
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        def acts_as_settings(options = {})
	    class_eval { cattr_accessor :nil_value }
	    self.nil_value = ([nil] << options[:nil_value]).flatten.uniq
	    serialize :settings
	    include ActiveRecord::Acts::Settings::InstanceMethods
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
		    val = *args
		    self.settings_will_change! if self.respond_to?(:settings_will_change!)
		    if self.nil_value.include? val #val.blank? or val == '0'
			self.settings[sym] = nil 
		    else
			self.settings[sym] = val
		    end
		else
		    return self.settings[name.to_sym]
		end
	    end
	end
      end
    end
  end
end
