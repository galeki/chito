class Sidebar
    attr_accessor :id, :info, :content, :jump, :default_position, :default_title, :plugin_id, :config
    mattr_accessor :sidebars, :user

    @@sidebars = []
    @@user = nil

    def self.add(sidebar)
      @@sidebars << sidebar
    end
    
    def title
        @@user.send(title_name) || @default_title || info
    end
    
    def info
        I18n.t :info, :scope => [:plugins, self.plugin_id.to_sym, self.id.to_sym], :default => @default_title || @info
    end
    
    def form_url
        "/admin/remote_form/#{self.plugin_id}/#{self.id}_config"
    end

    def show?
        @@user.send(show_name)
    end

    def show=(e)
        @@user.send("#{show_name}=", e)
    end

    def position
        @@user.send(position_name) ? @@user.send(position_name).to_i : @default_position.to_i
    end

    def position=(e)
        @@user.send("#{position_name}=", e)
    end

    def field
        @@user.send(field_name) || :chito_default
    end

    def field=(e)
        @@user.send("#{field_name}=", e)
    end

    def show_name
        "show_#{@id}".to_sym
    end

    def title_name
        "#{@id}_title".to_sym
    end

    def position_name
        "#{@id}_position".to_sym
    end

    def field_name
        "#{@id}_field".to_sym
    end

end
