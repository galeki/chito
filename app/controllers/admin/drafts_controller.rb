class Admin::DraftsController <  Admin::ArticleBaseController
    after_filter(:only => [:create, :update]) {|c| c.chito_cache_expire(:type => "posts_index/*")}

    def index
	@categories = @user.categories
	@drafts = @user.find_articles(:type => :drafts, :category_id => params[:category_id], :page => params[:page], :per_page => 20)
    end

    def create
	super
	save_draft
	unless_continue_edit do
	    notice_stickie t(:draft_successfully_created, :scope => [:txt, :controller, :admin, :drafts])
	    redirect_to admin_drafts_path
	end
    end

    def update
	super
	save_draft
	unless_continue_edit do
	    notice_stickie t(:draft_successfully_saved, :scope => [:txt, :controller, :admin, :drafts])
	    redirect_to admin_drafts_path
	end
    end

    def destroy
	super
	notice_stickie t(:draft_successfully_deleted, :scope => [:txt, :controller, :admin, :drafts])
	redirect_to admin_drafts_path(:page => params[:page]) 
    end  

    def destroy_selected
	super
	notice_stickie t(:drafts_successfully_deleted, :scope => [:txt, :controller, :admin, :drafts])
	redirect_to admin_drafts_path(:page => params[:page]) 
    end

    private

    def save_draft
	@article.is_draft = true
	@article.save
    end
end
