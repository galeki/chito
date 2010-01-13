require "highlight_search_word"

plugin = ChitoPlugin.new do
    self.id = "highlight_search_word"
    self.name = "Highlight Search Word"
    self.version = "1.0.1"
    self.writer = ""
    self.web = "http://"
    self.contributers = ""
    self.category = ""
    self.info = ""
    self.no_config = false    
end
ChitoPlugin.add(plugin)
