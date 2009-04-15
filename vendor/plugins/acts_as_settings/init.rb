require "acts_as_settings"

ActiveRecord::Base.send(:include, ActiveRecord::Acts::Settings)
