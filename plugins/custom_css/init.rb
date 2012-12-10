require 'custom_css'

plugin = ChitoPlugin.new do
    self.id = "custom_css"
    self.name = "Custom CSS"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = ""
end
ChitoPlugin.add(plugin)

