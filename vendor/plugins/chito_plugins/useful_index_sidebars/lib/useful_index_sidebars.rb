module IndexControllerPlugin
	private
	def get_useful_index_sidebars_needed_before_index_show
            if @index.show_user_updates
                uname = @index.user_of_user_updates || 'official'
                u = User.find_by_name(uname)
                if u
                    @user_update_posts = u.posts.order('created_at desc').limit(@index.user_updates_number.to_num(5))
                else
                    @user_update_posts = []
                end
            end

            if @index.show_new_reg_users
                @new_reg_users = User.order('created_at desc').limit(@index.new_reg_users_number.to_num(10))
            end

            if @index.show_index_list
                @index_list = Index.order('id')
            end

        end
end

bar = IndexSidebar.new 
bar.id = :user_updates
bar.info = 'User Updates'
bar.plugin_id = :useful_index_sidebars
bar.config = true
bar.default_position = 2
IndexSidebar.add(bar)

bar = IndexSidebar.new 
bar.id = :login_field
bar.info = 'Login Field'
bar.plugin_id = :useful_index_sidebars
bar.default_position = 1
#bar.config = true
IndexSidebar.add(bar)

bar = IndexSidebar.new 
bar.id = :new_reg_users
bar.info = 'New Users'
bar.default_position = 3
bar.plugin_id = :useful_index_sidebars
bar.config = true
IndexSidebar.add(bar)

bar = IndexSidebar.new
bar.id = :custom_index_sidebar_1
bar.info = "Custom Index Sidebar 1"
bar.default_position = 4
bar.plugin_id = :useful_index_sidebars
bar.config = true
IndexSidebar.add(bar)

bar = IndexSidebar.new
bar.id = :custom_index_sidebar_2
bar.info = "Custom Index Sidebar 2"
bar.default_position = 5
bar.plugin_id = :useful_index_sidebars
bar.config = true
IndexSidebar.add(bar)

bar = IndexSidebar.new
bar.id = :custom_index_sidebar_3
bar.info = "Custom Index Sidebar 3"
bar.default_position = 6
bar.plugin_id = :useful_index_sidebars
bar.config = true
IndexSidebar.add(bar)

bar = IndexSidebar.new
bar.id = :index_managers
bar.info = "Managers"
bar.default_position = 0
bar.plugin_id = :useful_index_sidebars
bar.config = false
IndexSidebar.add(bar)

bar = IndexSidebar.new
bar.id = :index_rss_icon
bar.info = "Feed"
bar.default_position = 0
bar.plugin_id = :useful_index_sidebars
bar.config = true
IndexSidebar.add(bar)

bar = IndexSidebar.new
bar.id = :index_list
bar.info = "Indices"
bar.default_position = 0
bar.plugin_id = :useful_index_sidebars
#bar.config = true
IndexSidebar.add(bar)

bar = IndexSidebar.new
bar.id = :index_bulletin
bar.info = "Bulletin"
bar.default_position = 0
bar.plugin_id = :useful_index_sidebars
#bar.config = true
IndexSidebar.add(bar)
