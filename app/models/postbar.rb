class Postbar < Sidebar
    mattr_accessor :postbars, :user    
    @@postbars = []
    @@user = nil

    def self.add(postbar)
      @@postbars << postbar
    end
end
