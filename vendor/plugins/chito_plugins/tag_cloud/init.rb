require 'tag_cloud'

plugin = ChitoPlugin.new do
    self.id = "tag_cloud"
    self.name = "Tag Cloud"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = true
end
ChitoPlugin.add(plugin)
