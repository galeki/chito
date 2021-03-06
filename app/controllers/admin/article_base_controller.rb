class Admin::ArticleBaseController <  Admin::BaseController
    include Admin::ArticleControllerPlugin

  def new
    @article = Article.new
    @article.prepare(@user, params)    
    @article.is_draft = true
    @article.auto_brief = true
    @categories = @user.categories
    @indices = Index.order('id')
    @selected = @user.categories.first.id if @user.categories.first
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
    @indices = Index.order('id')
    @selected = @article.category.id if @article.category
  end

  def update
    @article = @user.articles.find(params[:id])
    @article.prepare(@user, params)
    do_something :before_article_save     
    @article.make_brief
  end

  def autosave
    @article = @user.articles.find(params[:id])
    unless params[:content].blank?
        @article.content = params[:content]
        @article.is_draft = true
        @success = true if @article.save
    end
    render "admin/share/autosave"
  end

  def destroy
    @article = @user.articles.find(params[:id])
    @article.is_deleted = true
    @article.save
  end

  def destroy_selected
    if params[:ids]
        for article in @user.articles.find(params[:ids])
            article.is_deleted = true
            article.save
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
