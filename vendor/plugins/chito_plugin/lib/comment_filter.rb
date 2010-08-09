class CommentFilter
    attr_accessor :id, :hook, :name, :config, :plugin_id        
    mattr_accessor :user, :filters
     @@filters = []
   
    def initialize(id, name, hook)
	@id, @name, @hook = id, name, hook
    end

    def self.add(filter)
	 @@filters << filter
    end

    def name
	I18n.t :name, :scope => [:plugins, :comment_filter, @id.to_sym], :default => @name
    end

    def form_url
	"/admin/remote_form/#{self.plugin_id || self.id}/#{self.id}_config"
    end

    def position
	 @@user.send("comment_filter_#{self.id}_position").to_i
    end

    def position=(n)
	@@user.send("comment_filter_#{self.id}_position=", n)	
    end

    def enable
	 @@user.send("enable_comment_filter_#{self.id}")
    end
    
    def enable=(n)
	@@user.send("enable_comment_filter_#{self.id}=", n)
    end

end
