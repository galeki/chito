require 'random_posts'

plugin = ChitoPlugin.new do
    self.id = "random_posts"
    self.name = "Random Posts"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = "Show random posts bar"
    self.no_config = true
end
ChitoPlugin.add(plugin)
