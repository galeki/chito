require "akismetor/lib/akismetor"
require "akismet_comment_filter"

plugin = ChitoPlugin.new do
    self.id = "akismet_comment_filter"
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
