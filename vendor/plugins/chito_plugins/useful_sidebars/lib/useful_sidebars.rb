module BlogHelperPlugin
	def show_categories_bar
	    plugin_render :useful_sidebars, :categories
	end
	def show_head_bar
	    plugin_render :useful_sidebars, :head
	end
	def show_new_comments_bar
	    plugin_render :useful_sidebars, :new_comments
	end
	def show_new_messages_bar
	    plugin_render :useful_sidebars, :new_messages
	end
	def show_search_bar
	    plugin_render :useful_sidebars, :search
	end
	def show_links_bar
	    plugin_render :useful_sidebars, :links
	end
	def show_meta_bar
	    plugin_render :useful_sidebars, :meta
	end
	def show_blog_counter_bar
	    plugin_render :useful_sidebars, :counter
	end
	def show_page_bar
	    plugin_render :useful_sidebars, :page
	end
end
module BlogControllerPlugin
	private
	def get_useful_sidebars_needed_before_blog_show
	    if @user.show_new_comments && !sidebar_cache_enable(:new_comments)
		num = @user.new_comments_number.to_i
		@new_comments = @user.new_comments(num)	    
		@comment_cut = @user.new_comments_cut.to_num(13)
	    end

	    if @user.show_new_messages && !sidebar_cache_enable(:new_messages)
		num = @user.new_messages_number.to_i
		@new_messages = @user.new_messages(num)
		@message_cut = @user.new_messages_cut.to_num(13)
	    end

	    if @user.show_links && !sidebar_cache_enable(:links)
		@links = @user.links
	    end

	    if @user.show_categories && !sidebar_cache_enable(:categories)
		@categories = @user.categories
	    end
        end

	def count_blog_view_and_post_view_before_post_show
	    if session[:user_id].to_s != @user.id.to_s
	        @user.increment!(:blog_read) 
		@post.increment!(:read_count)
	    end
	end
end
module ApplicationPlugin
	private

	def add_new_comments_in_sidebar
		bar = Sidebar.new 
		bar.id = :new_comments
		bar.info = 'Recent comments'
		bar.plugin_id = :useful_sidebars
		bar.config = true
		bar.default_position = 2
		Sidebar.add(bar)
	end
	def add_new_messages_in_sidebar
	    bar = Sidebar.new 
		bar.id = :new_messages
		bar.info = 'Recent messages'
		bar.plugin_id = :useful_sidebars
		bar.default_position = 3
		bar.config = true
		Sidebar.add(bar)
	end
	def add_links_in_sidebar
	    bar = Sidebar.new 
		bar.id = :links
		bar.info = 'Links'
		bar.default_position = 4
		bar.jump = admin_links_path
		bar.plugin_id = :useful_sidebars
		Sidebar.add(bar)
	end
	def add_blog_counter_in_sidebar
	    bar = Sidebar.new 
		bar.id = :blog_counter
		bar.info = 'Counter'
		bar.default_position = 10
		bar.plugin_id = :useful_sidebars
		Sidebar.add(bar)
	end
	def add_head_in_sidebar
	    bar = Sidebar.new 
		bar.id = :head
		bar.info = 'Avatar'
		bar.default_position = 0
		bar.default_title = "Avatar"
		bar.plugin_id = :useful_sidebars
		Sidebar.add(bar)
	end
	def add_search_in_sidebar
	    bar = Sidebar.new 
		bar.id = :search
		bar.info = 'Search'
		bar.default_position = 0
		bar.plugin_id = :useful_sidebars
		Sidebar.add(bar)
	end
	def add_categories_in_sidebar
	    bar = Sidebar.new 
		bar.id = :categories
		bar.info = 'Categories'
		bar.default_position = 1
		bar.jump = admin_categories_path
		bar.plugin_id = :useful_sidebars
		Sidebar.add(bar)
	end
	def add_meta_in_sidebar
	    bar = Sidebar.new
	    bar.id = :meta
	    bar.info = "Meta"
	    bar.default_position = 999
	    bar.plugin_id = :useful_sidebars
	    Sidebar.add(bar)
	end
	def add_page_in_sidebar
	    bar = Sidebar.new
	    bar.id = :page
	    bar.info = "Page"
	    bar.default_position = 1
	    bar.plugin_id = :useful_sidebars
	    Sidebar.add(bar)
	end
end
