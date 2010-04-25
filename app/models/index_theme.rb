class IndexTheme < UserTheme
    PATH = File.expand_path(File.join(RAILS_ROOT, "themes", "index"))
    PUBLIC_PATH =  File.expand_path(File.join(RAILS_ROOT, "public", "index", "themes"))
    LIST = Dir[PATH + "/*"].map{|t| File.basename(t)}.sort
    COPIED = {}

end
