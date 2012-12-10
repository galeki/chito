class IndexSidebar < Sidebar
    mattr_accessor :index_sidebars, :user

    @@index_sidebars = []
    @@user

    def self.add(sidebar)
      @@index_sidebars << sidebar
    end
    
    def form_url
        "/admin/remote_form/#{self.plugin_id}/#{self.id}_config?index_id=#{@@user.id}"
    end
end
