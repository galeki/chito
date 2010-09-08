class PostsController < BlogController

  def show
    @post = @user.articles.find(params[:id])
    @comments = @post.comments
    respond_to do |format|
	format.html do
	    get_postbars
	    @category = @post.category
	    @comment = Feedback.new
	    @previous_post = @post.prev
	    @next_post = @post.next
	    @titles.unshift @post.title
	    @title = @titles * " - "
	    do_something :before_post_show
	end
	format.rss
	#format.xml {render :xml => @post.to_xml(:include => [ :comments ])}
    end

  end

  def index
    respond_to do |format|
	format.html do
	    if request.path.sub("/", "").blank? && @user.fontpage_id
		@page = @user.pages.find(@user.fontpage_id) rescue nil
		redirect_to(@page.permalink.blank? ? page_path(@page) : page_permalink_path(@page.permalink)) if @page
	    end
	    unless chito_cache_enable(_params.merge(:type => :posts_index, :theme => @user.theme))
		@posts = @user.find_articles :type => :posts, :category_id => params[:category_id], 
					     :tag => params[:tag_name], :keyword => params[:s],
                                             :year => params[:year], :month => params[:month],
					     :page => params[:page], :per_page => @user.blog_per_page.to_num(10)
	    end
	    @category = @user.categories.find(params[:category_id]) if params[:category_id]
	    @titles.unshift(@category.name) if @category
	    @title = @titles * " - "
	    do_something :before_list_show
	end
	format.rss do
	    @posts = @user.find_articles :type => :posts, :category_id => params[:category_id], 
					 :per_page => 12
	    do_something :before_list_rss_show
	end
    end
  end

  def cancel_comment_notifier
    @post = @user.articles.find(params[:id])
    if @post.emails && @post.emails.has_key?(params[:email]) && @post.emails[params[:email]] == params[:key]
	@post.emails.delete(params[:email])
	@post.save
	notice_stickie t(:cancel_comment_notifier, :scope => [:txt, :controller, :posts], :title => @post.title) 
    else
	error_stickie t(:no_comment_notifier, :scope => [:txt, :controller, :posts], :title => @post.title)
    end
  end
end
