class IndexTheme < UserTheme
    PATH = File.expand_path(File.join(Rails.root, "themes", "index"))
    PUBLIC_PATH =  File.expand_path(File.join(Rails.root, "public", "themes", "index"))
    LIST = Dir[PATH + "/*"].map{|t| File.basename(t)}.sort
    COPIED = {}

end
