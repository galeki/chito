class IndexSidebar < Sidebar
    mattr_accessor :items, :user

    @@items = []
    @@user

    def self.add(sidebar)
      @@items << sidebar
    end
    
end
