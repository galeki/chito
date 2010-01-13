require 'custom_sidebar_item'

plugin = ChitoPlugin.new do
    self.id = "custom_sidebar_item"
    self.name = "Custom Sidebars"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = true
end
ChitoPlugin.add(plugin)
