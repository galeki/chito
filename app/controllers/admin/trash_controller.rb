class Admin::TrashController <  Admin::ArticleBaseController
    after_filter(:only => :restore) {|c| c.chito_cache_expire(:type => "posts_index/*")}
    after_filter(:only => :restore) {|c| c.sidebar_cache_expire(:archive) }
    
    def index
        @posts = @user.find_articles(:type => :trash, :page => params[:page], :per_page => 20)
    end

    def restore
        @article = @user.articles.find(params[:id])
        if @article
            @article.is_deleted = false
            @article.save
            notice_stickie t(:aritlce_successfully_restored, :scope => [:txt, :controller, :admin, :trash])
        else
            error_stickie t(:article_restore_failed, :scope => [:txt, :controller, :admin, :trash])
        end
        redirect_to admin_trash_index_path(:page => params[:page]) 
    end

    def destroy
        @article = @user.articles.find(params[:id])
        @article.destroy
        notice_stickie t(:post_successfully_deleted, :scope => [:txt, :controller, :admin, :posts])
        redirect_to admin_trash_index_path(:page => params[:page]) 
    end    

    def destroy_all
        for article in @user.find_articles(:type => :trash)
            article.destroy
        end
        notice_stickie t(:posts_successfully_deleted, :scope => [:txt, :controller, :admin, :posts])
        redirect_to admin_trash_index_path
    end

end

