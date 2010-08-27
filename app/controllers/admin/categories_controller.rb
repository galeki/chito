class Admin::CategoriesController <  Admin::BaseController
	in_place_edit_for :category, :name
	in_place_edit_for :category, :info
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
    render :update do |page|
	page.replace_html "updater", :partial => "category_position"
	page.visual_effect :highlight, "position_update", :startcolor => '#ffff00',
			   :endcolor => '#ffffff',
			   :duration => 5.0		
    end
  end

  def create
    @category = @user.categories.new(params[:category])
    if @category.save
	respond_to do |format|
	    format.html {@update = "all_categories"; @partial = "category"}
	    format.js {@update = "categories_checkboxes"; @partial = "category_checkbox"}
	end
	render :update do |page|
	    page.insert_html :top, @update, :partial => @partial 
	    page.visual_effect :highlight, "category_#{@category.id}", :startcolor => '#ffff00',
			       :endcolor => '#ffffff',
			       :duration => 8.0
	end
    else
	error_stickie(@category.errors.full_messages * "; ")
 	render :update do |page|
 	  page.replace_html "updater", :partial => "share/error" 
	  page.visual_effect :BlindDown, "updater"
         end
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
