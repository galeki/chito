require "rss_icon_sidebar"

plugin = ChitoPlugin.new do
    self.id = "rss_icon_sidebar"
    self.name = ""
    self.version = "1.0.0"
    self.writer = ""
    self.web = "http://"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = false    
    self.min_chito_version = "1.0.0"
end
ChitoPlugin.add(plugin)
