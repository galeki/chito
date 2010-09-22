require 'page_patch'

plugin = ChitoPlugin.new do
    self.id = "page_patch"
    self.name = "Page Patch"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = ""
end
ChitoPlugin.add(plugin)
