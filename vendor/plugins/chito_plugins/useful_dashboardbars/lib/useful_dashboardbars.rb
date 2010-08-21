module ApplicationPlugin
    private
    
    def find_official_notices_and_new_posts_before_admin_dashboard_show
	@notices = []
	of = User.find_by_name('official')
	@notices = of.posts.order('created_at desc').limit(4) if of

	num = @user.numbers_of_new_posts_in_admin.to_num(6)
	num = 30 if num > 50
	@new_posts = Article.new_posts(num)

        @new_comments = @user.new_comments(4)	    
	@new_messages = @user.new_messages(4)	    
	@comments_size = @user.comments.size
	@messages_size = @user.messages.size
	@posts_size = @user.posts.size
	@drafts_size = @user.drafts.size
    end
end

bar = Dashboardbar.new
bar.id = :dashboard_new_comments
bar.info = 'Recent comments'
bar.plugin_id = :useful_dashboardbars
bar.config = true
bar.default_position = 1
Dashboardbar.add(bar)


bar = Dashboardbar.new
bar.id = :dashboard_new_messages
bar.info = 'Recent Messages'
bar.plugin_id = :useful_dashboardbars
bar.config = true
bar.default_position = 2
Dashboardbar.add(bar)


bar = Dashboardbar.new
bar.id = :dashboard_statistics
bar.info = 'Statistics'
bar.plugin_id = :useful_dashboardbars
bar.config = false
bar.default_position = 3
Dashboardbar.add(bar)


bar = Dashboardbar.new
bar.id = :dashboard_bulletin
bar.info = 'Bulletin'
bar.plugin_id = :useful_dashboardbars
bar.config = false
bar.default_position = 4
Dashboardbar.add(bar)


bar = Dashboardbar.new
bar.id = :dashboard_posts_update
bar.info = 'Posts Update'
bar.plugin_id = :useful_dashboardbars
bar.config = true
bar.default_position = 5
Dashboardbar.add(bar)


bar = Dashboardbar.new
bar.id = :dashboard_welcome
bar.info = 'Welcome'
bar.plugin_id = :useful_dashboardbars
bar.config = true
bar.default_position = 1
Dashboardbar.add(bar)

