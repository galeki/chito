class Theme
    THEME_PATH = File.expand_path(File.join(RAILS_ROOT, "themes"))
    PUBLIC_PATH =  File.expand_path(File.join(RAILS_ROOT, "public/themes"))
    THEME_LIST = Dir[THEME_PATH + "/*"].map{|t| File.basename(t)}.sort
    THEME_COPIED = {}

    def self.file_path(theme, file)
	File.join THEME_PATH, theme, file
    end

    def self.copy_to_public(theme)
	unless THEME_COPIED[theme]
	    dst = File.join(PUBLIC_PATH, theme)
	    src = File.join(THEME_PATH, theme)
	    FileUtils.makedirs dst
	    ['images', 'stylesheets', 'javascripts', 'screenshot.png'].each do |f|
		FileUtils.cp_r File.join(src, f), dst
	    end
	    THEME_COPIED[theme] = true
	end

	rescue nil
    end

end
