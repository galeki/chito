class Dashboardbar < Sidebar
    mattr_accessor :dashboardbars, :user    
    @@dashboardbars = []
    @@user = nil

    def self.add(bar)
      @@dashboardbars << bar
    end
end
