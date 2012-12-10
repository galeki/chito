require 'img_resize'

plugin = ChitoPlugin.new do
    self.id = "img_resize"
    self.name = "Image auto resizer"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = ""
end
ChitoPlugin.add(plugin)
