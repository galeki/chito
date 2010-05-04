class IndexSidebar < Sidebar
    mattr_accessor :index_sidebars, :user

    @@index_sidebars = []
    @@user

    def self.add(sidebar)
      @@index_sidebars << sidebar
    end
    
end
