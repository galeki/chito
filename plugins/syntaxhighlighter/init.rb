require "syntaxhighlighter"

plugin = ChitoPlugin.new do
    self.id = "syntaxhighlighter"
    self.name = "SyntaxHighlighter"
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
