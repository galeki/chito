require 'auto_complete_tag'

plugin = ChitoPlugin.new do
    self.id = "auto_complete_tag"
    self.name = "Tag Auto Complete"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = ""
end
ChitoPlugin.add(plugin)
