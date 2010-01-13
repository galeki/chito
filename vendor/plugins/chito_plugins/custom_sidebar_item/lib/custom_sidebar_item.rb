    module BlogHelperPlugin
	def show_custom_sidebar_item_1_bar
	    @user.custom_sidebar_item_1_content || ''
	end
	def show_custom_sidebar_item_2_bar
	    @user.custom_sidebar_item_2_content || ''
	end
	def show_custom_sidebar_item_3_bar
	    @user.custom_sidebar_item_3_content || ''
	end
	def show_custom_sidebar_item_4_bar
	    @user.custom_sidebar_item_4_content || ''
	end
	def show_custom_sidebar_item_5_bar
	    @user.custom_sidebar_item_5_content || ''
	end
    end
    module ApplicationPlugin
	private
	def add_custom_sidebar_item_in_sidebar
	    bar = Sidebar.new
	    bar.id = :custom_sidebar_item_1
	    bar.info = 'Cumtom Sidebar 1'
	    bar.plugin_id = :custom_sidebar_item
	    bar.config = true
	    bar.default_position = 99
	    Sidebar.add(bar)
	    bar = Sidebar.new
	    bar.id = :custom_sidebar_item_2
	    bar.info = 'Cumtom Sidebar 2'
	    bar.default_position = 100
	    bar.config = true
	    bar.plugin_id = :custom_sidebar_item
	    Sidebar.add(bar)
	    bar = Sidebar.new
	    bar.id = :custom_sidebar_item_3
	    bar.info = 'Cumtom Sidebar 3'
	    bar.default_position = 100
	    bar.config = true
	    bar.plugin_id = :custom_sidebar_item
	    Sidebar.add(bar)
	    bar = Sidebar.new
	    bar.id = :custom_sidebar_item_4
	    bar.info = 'Cumtom Sidebar 4'
	    bar.default_position = 100
	    bar.config = true
	    bar.plugin_id = :custom_sidebar_item
	    Sidebar.add(bar)
	    bar = Sidebar.new
	    bar.id = :custom_sidebar_item_5
	    bar.info = 'Cumtom Sidebar 5'
	    bar.default_position = 100
	    bar.config = true
	    bar.plugin_id = :custom_sidebar_item
	    Sidebar.add(bar)
	end
    end
