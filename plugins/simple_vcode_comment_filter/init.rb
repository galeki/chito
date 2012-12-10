require "simple_vcode_comment_filter"

plugin = ChitoPlugin.new do
    self.id = "simple_vcode_comment_filter"
    self.name = ""
    self.version = "1.0.0"
    self.writer = ""
    self.web = "http://"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = true    
end
ChitoPlugin.add(plugin)
