module BlogHelperPlugin
	def show_user_updates_bar
	    plugin_render :useful_index_sidebars, :user_updates
	end
	def show_login_field_bar
	    plugin_render :useful_index_sidebars, :login_field
	end
	def show_new_reg_users_bar
	    plugin_render :useful_index_sidebars, :new_reg_users
	end
        def show_custom_index_sidebar_1_bar
	    plugin_render :useful_index_sidebars, :custom_index_sidebar_1
        end
        def show_custom_index_sidebar_2_bar
	    plugin_render :useful_index_sidebars, :custom_index_sidebar_2
        end
        def show_custom_index_sidebar_3_bar
	    plugin_render :useful_index_sidebars, :custom_index_sidebar_3
        end
end
module IndexControllerPlugin
	private
	def get_useful_index_sidebars_needed_before_index_show
	    #if @user.show_new_comments && !sidebar_cache_enable(:new_comments)
	    #	num = @user.new_comments_number.to_i
	    #	@new_comments = @user.new_comments(num)	    
	    #	@comment_cut = @user.new_comments_cut.to_num(20)
	    #end

            if @index.show_user_updates
                uname = @index.user_of_user_updates || 'official'
                u = User.find_by_name(uname)
                if u
                    @user_update_posts = u.posts.find(:all, :limit => @index.user_updates_number.to_num(5))
                else
                    @user_update_posts = []
                end
            end

            if @index.show_new_reg_users
                @new_reg_users = User.find(:all, :order => 'created_at desc', :limit => @index.new_reg_users_number.to_num(10))
            end

        end
end
module ApplicationPlugin
    private
	def add_user_update_in_index_sidebar
		bar = IndexSidebar.new 
		bar.id = :user_updates
		bar.info = 'User Updates'
		bar.plugin_id = :useful_index_sidebars
		bar.config = true
		bar.default_position = 2
		IndexSidebar.add(bar)
	end
	def add_login_field_in_index_sidebar
	        bar = IndexSidebar.new 
		bar.id = :login_field
		bar.info = 'Login Field'
		bar.plugin_id = :useful_index_sidebars
		bar.default_position = 1
		#bar.config = true
		IndexSidebar.add(bar)
	end
	def add_new_reg_users_in_index_sidebar
	        bar = IndexSidebar.new 
		bar.id = :new_reg_users
		bar.info = 'New Users'
		bar.default_position = 3
		bar.plugin_id = :useful_index_sidebars
		bar.config = true
		IndexSidebar.add(bar)
	end
        def add_custom_index_bar_1_in_index_sidebar
                bar = IndexSidebar.new
                bar.id = :custom_index_sidebar_1
                bar.info = "Custom Index Sidebar 1"
                bar.default_position = 4
                bar.plugin_id = :useful_index_sidebars
                bar.config = true
                IndexSidebar.add(bar)
        end
        def add_custom_index_bar_2_in_index_sidebar
                bar = IndexSidebar.new
                bar.id = :custom_index_sidebar_2
                bar.info = "Custom Index Sidebar 2"
                bar.default_position = 5
                bar.plugin_id = :useful_index_sidebars
                bar.config = true
                IndexSidebar.add(bar)
        end
        def add_custom_index_bar_3_in_index_sidebar
                bar = IndexSidebar.new
                bar.id = :custom_index_sidebar_3
                bar.info = "Custom Index Sidebar 3"
                bar.default_position = 6
                bar.plugin_id = :useful_index_sidebars
                bar.config = true
                IndexSidebar.add(bar)
        end
end
