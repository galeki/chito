class Admin::ArticlesController <  Admin::BaseController
    include Admin::ArticleControllerPlugin

  def new
    @article = Article.new
    @article.prepare(@user, params)    
    @article.is_draft = true
    @article.auto_brief = true
    @categories = @user.categories
    @selected = @user.categories.find(:first).id
    @article.save
    redirect_to edit_admin_draft_path(@article)
  end

  def create
    @article = Article.new
    @article.prepare(@user, params)
    do_something :before_article_save
    @article.make_brief
  end

  def edit
    @article = @user.articles.find(params[:id])
    @categories = @user.categories
    @selected = @article.category.id if @article.category
  end

  def update
    @article = @user.articles.find(params[:id])
    @article.prepare(@user, params)
    do_something :before_article_save     
    @article.make_brief
  end

  def destroy
    @article = @user.articles.find(params[:id])
    @article.destroy
  end

  def destroy_selected
    if params[:ids]
	for article in @user.articles.find(params[:ids])
	    article.destroy
	end
    end
  end

  private
  
  def unless_continue_edit
    if params[:continue_editing]
	@article.is_draft = true
	@article.save
	notice_stickie t("txt.controller.admin.articles.draft_saved", :time => Time.now.to_s(:update))
	redirect_to edit_admin_draft_path(@article)
    else
	@article.save
	yield
    end
  end

end
