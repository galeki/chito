require 'relative_posts'

plugin = ChitoPlugin.new do
    self.id = "relative_posts"
    self.name = "Relative Posts"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = true
end
ChitoPlugin.add(plugin)
