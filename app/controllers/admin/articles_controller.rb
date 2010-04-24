class Admin::ArticlesController < Admin::BaseController
    before_filter :chito_admin_authorize    

  def index
    @posts = Article.paginate :per_page => 30, :page => params[:page],
                             :conditions => ["articles.bit_opt = 0"], 
                             :include => [:comments, :category, :user],
                             :order => 'articles.created_at DESC'
  end

  def increase_rank
    @post = Article.find(params[:id])
    @post.increment!(:rank)

    render :update do |page|
        page.replace_html "post#{@post.id}_rank", @post.rank.to_s
        page.visual_effect :highlight, "post#{@post.id}_rank", :startcolor => '#ffff00',
                           :endcolor => '#ffffff',
                           :duration => 4.0
    end
  end

  def decrease_rank
    @post = Article.find(params[:id])
    @post.decrement!(:rank)

    render :update do |page|
        page.replace_html "post#{@post.id}_rank", @post.rank.to_s
        page.visual_effect :highlight, "post#{@post.id}_rank", :startcolor => '#ff0000',
                           :endcolor => '#ffffff',
                           :duration => 4.0
    end
  end

  def destroy
    @user = User.find(params[:id])
    notice_stickie t(:user_deleted, :scope => [:txt, :controller, :admin, :users]) if @user.destroy
    redirect_to admin_users_path   
  end

end
