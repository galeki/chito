class Admin::CategoriesController <  Admin::BaseController
        in_place_edit_for :category, :name
        in_place_edit_for :category, :info
        in_place_edit_for :category, :permalink
        after_filter(:except => :index) { |c| c.sidebar_cache_expire :categories }

  def index
    @categories = @user.categories
  end

  def set_position
    @categories = @user.categories
    params[:all_categories].each_with_index do |id,idx| 
        @category = @categories.find(id) 
        @category.update_attributes(:position => idx) if @category
    end
  end

  def create
    @category = @user.categories.new(params[:category])
    if @category.save
        @created = true
        respond_to do |format|
            format.html {}
            format.js do
                if params[:editor]
                    @update = "categories_checkboxes"; @partial = "category_checkbox"
                else
                    @update = "all_categories"; @partial = "category"
                end
            end
        end
    else
        error_stickie(@category.errors.full_messages * "; ")
    end 
  end

  def destroy
    @category = @user.categories.find(params[:id])
    if @user.categories.size == 1
        error_stickie t(:must_have_a_category, :scope => [:txt, :controller, :admin, :categories])
    else
        @category.destroy
        notice_stickie t(:category_successfully_deleted, :scope => [:txt, :controller, :admin, :categories])
    end
    redirect_to admin_categories_path
  end

end
