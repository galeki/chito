require 'textile_mode'

plugin = ChitoPlugin.new do
    self.id = "textile_mode"
    self.name = "Textile edit mode"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = true    
end
ChitoPlugin.add(plugin)
