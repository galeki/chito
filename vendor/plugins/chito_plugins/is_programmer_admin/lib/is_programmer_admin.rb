module ApplicationPlugin
    private
    
    def find_official_notices_and_new_posts_before_admin_dashboard_show
	@notices = []
	of = User.find_by_name('official')
	@notices = of.posts.find(:all, :limit => 4) if of

	num = @user.numbers_of_new_posts_in_admin.to_num(6)
	num = 30 if num > 50
	@new_posts = Article.find(:all, 
				  :conditions => ["bit_opt = 0 and user_id != 418 and user_id != 950 and user_id != 951 and user_id != 952"], :order => 'created_at DESC', 
				  :limit => num)
    end
end

module ApplicationHelperPlugin
    def show_is_programmer_new_posts_in_admin_dashboard_sidebar
	plugin_render :is_programmer_admin, :new_posts
    end

    def show_official_notices_in_admin_dashboard
	plugin_render :is_programmer_admin, :official_notices
    end
end
