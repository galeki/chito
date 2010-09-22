class Navbar < Sidebar
    attr_accessor :page, :default_position, :default_title, :config, :plugin_id
    attr_writer :id, :title, :url
    mattr_accessor :user, :navbars

    @@navbars =[]
    @@user = nil
    
    def self.add(bar)
      @@navbars << bar
    end

    def initialize(page = nil)
        @page = page
    end

    def id
        @page ? @page.id.to_s.to_sym : @id.to_sym
    end

    def title
        @page ? @page.title : I18n.t("plugins.navbar.#{@plugin_id}.#{@id}.name", :default => @@user.send(title_name) || @default_title || @title)
    end
    alias i18n_title title

    def url
        @@user.send("#{self.id}_url") || @url || "/"
    end

    def position
        @page ? @page.position.to_s.to_i : (@@user.send(position_name) || @default_position)
    end

    def position=(n)
        if @page
            @page.send("position=", n)
        else
            @@user.send("#{position_name}=", n)
        end
    end

    def show?
        @page ? @page.show_as_navbar : @@user.send(show_name)
    end

    def show=(s)
        if @page
            @page.send("show_as_navbar=", s) 
        else
            @@user.send("#{show_name}=", s)
        end
    end 

    def position_name
        "navbar_#{self.id}_position".to_sym
    end

    def show_name
        "show_navbar_#{self.id}".to_sym
    end

end
