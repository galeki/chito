require "custom_navbars"

plugin = ChitoPlugin.new do
    self.id = "custom_navbars"
    self.name = "Custom Navbars"
    self.version = "1.0.1"
    self.writer = ""
    self.web = "http://"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = true    
end
ChitoPlugin.add(plugin)
