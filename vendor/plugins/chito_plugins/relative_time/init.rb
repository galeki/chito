require 'relative_time'

plugin = ChitoPlugin.new do
    self.id = "relative_time"
    self.name = "Relative Time"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = ""
end
ChitoPlugin.add(plugin)

