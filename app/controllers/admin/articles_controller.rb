class Admin::ArticlesController < Admin::BaseController
    before_filter :chito_admin_authorize, :only => [:index, :destroy, :destroy_selected]    

  def index
    @posts = Article.paginate :per_page => 30, :page => params[:page],
                             :conditions => ["articles.bit_opt = 0"], 
                             :include => [:comments, :category, :user],
                             :order => 'articles.created_at DESC'
  end

  def increase_rank
    @post = Article.find(params[:id])
    return unless check_rank_authorize(@post.index_id)
    @post.increment!(:rank)
    expire_index(@post.index) if @post.index
  end

  def decrease_rank
    @post = Article.find(params[:id])
    return unless check_rank_authorize(@post.index_id)
    @post.decrement!(:rank)
    expire_index(@post.index) if @post.index
  end

  def destroy
    article = Article.find(params[:id])
    notice_stickie(t(:post_successfully_deleted, :scope => [:txt, :controller, :admin, :posts])) if article.destroy
    redirect_to admin_articles_path(:page => params[:page])   
  end

  def destroy_selected
    if params[:ids]
        for article in Article.find(params[:ids])
            article.destroy
        end
    end 
    notice_stickie t(:posts_successfully_deleted, :scope => [:txt, :controller, :admin, :posts])
    redirect_to admin_articles_path(:page => params[:page]) 
  end

end
