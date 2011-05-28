class Admin::PostsController <  Admin::ArticleBaseController
    after_filter(:except => :index) {|c| c.chito_cache_expire(:type => "posts_index/*")}
    after_filter(:except => [:index, :update, :recategory_selected]) do |c| 
        c.sidebar_cache_expire(:archive)
        c.sidebar_cache_expire(:calendar)
    end
    
    def index
        @categories = @user.categories
        @posts = @user.find_articles(:type => :posts, :category_id => params[:category_id], :page => params[:page], :per_page => 20)
    end

    def create
        super
#       @article.published = true
        save_and_redirect
        send_trackback(params[:trackbacks], @article)
    end

    def update
        super
        #unless @article.published
        #    @article.created_at = Time.now
        #    @article.published = true
        #end
        save_and_redirect
        send_trackback(params[:trackbacks], @article)
    end

    def destroy
        super
        notice_stickie t(:post_successfully_deleted, :scope => [:txt, :controller, :admin, :posts])
        redirect_to admin_posts_path(:page => params[:page]) 
    end    

    def destroy_selected
        super
        notice_stickie t(:posts_successfully_deleted, :scope => [:txt, :controller, :admin, :posts])
        redirect_to admin_posts_path(:page => params[:page]) 
    end

    def recategory_selected
        if params[:ids] && @category = @user.categories.find(params[:recategory])
            for article in @user.articles.find(params[:ids])
                article.category = @category
                article.save
            end
        end
        notice_stickie t(:posts_successfully_recategoried, :scope => [:txt, :controller, :admin, :posts])
        redirect_to admin_posts_path(:page => params[:page]) 
    end

    private
    
    def save_and_redirect
        @article.is_draft = false
        @article.is_page = false
        unless_continue_edit { redirect_to post_path(@article) }
    end

    def send_trackback(url, post)
        return if url.blank?
        post_url = post_url(post, :format => html)
        query = post.trackback_params.merge(:url => post_url).to_query
        trackback_url = URI.parse(url)
        Net::HTTP.start(trackback_url.host, trackback_url.port) do |http|
            path = trackback_url.path
            path << "?#{trackback_url.query}" if trackback_url.query
            http.post(path, query,'Content-type' => 'application/x-www-form-urlencoded; charset=utf-8')
        end

        rescue
    end
            
end

