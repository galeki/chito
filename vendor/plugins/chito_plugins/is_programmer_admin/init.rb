require "is_programmer_admin"

plugin = ChitoPlugin.new do
    self.id = "is_programmer_admin"
    self.name = ""
    self.version = "1.0.0"
    self.writer = ""
    self.web = "http://"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = true    
    self.min_chito_version = "1.0.6"
end
ChitoPlugin.add(plugin)
