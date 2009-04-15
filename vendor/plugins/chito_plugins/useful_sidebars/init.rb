require 'useful_sidebars'

plugin = ChitoPlugin.new do
    self.id = "useful_sidebars"
    self.name = "Useful Sidebars"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = true
end
ChitoPlugin.add(plugin)
