require "force_comment_avatar"

plugin = ChitoPlugin.new do
    self.id = "force_comment_avatar"
    self.name = ""
    self.version = "1.0.0"
    self.writer = ""
    self.web = "http://"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = true    
    self.min_chito_version = "1.0.0"
end
ChitoPlugin.add(plugin)
