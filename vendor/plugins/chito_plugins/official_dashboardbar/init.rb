require 'official_dashboardbar'

plugin = ChitoPlugin.new do
    self.id = "official_dashboardbar"
    self.name = "Useful Dashboardbars"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.com"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = true
end
ChitoPlugin.add(plugin)
