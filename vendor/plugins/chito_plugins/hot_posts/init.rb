require 'hot_posts'

plugin = ChitoPlugin.new do
    self.id = "hot_posts"
    self.name = "Hot Posts"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = "Show hot posts bar"
    self.no_config = true
end
ChitoPlugin.add(plugin)
