module BlogHelperPlugin
	def show_rss_icon_bar
	    plugin_render :rss_icon_sidebar, :rss_icon
	end
end
module ApplicationPlugin
    private
	def add_rss_icon_in_sidebar
		bar = Sidebar.new 
		bar.id = :rss_icon
		bar.info = 'RSS'
		bar.plugin_id = :rss_icon_sidebar
		bar.config = true
		bar.default_position = 0
		Sidebar.add(bar)
	end
end
