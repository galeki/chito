class Admin::DashboardController <  Admin::BaseController
    
    def index
	@new_comments = @user.new_comments(4)	    
	@new_messages = @user.new_messages(4)	    
	@comments_size = @user.comments.size
	@messages_size = @user.messages.size
	@posts_size = @user.posts.size
	@drafts_size = @user.drafts.size
	do_something :before_admin_dashboard_show
    end

    def logout
	logout_and_redirect_to
    end

end
