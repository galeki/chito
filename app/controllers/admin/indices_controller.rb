class Admin::IndicesController < Admin::BaseController
    self.prepend_view_path(IndexTheme::PATH) 
    before_filter :chito_admin_authorize, :only => [:index, :create, :add_manager, :remove_manager, :destroy]
    before_filter :index_manager_authorize, :only => [:show, :settings, :change_settings, :sidebar_position, :save_avatar]
    in_place_edit_for :index, :title
    in_place_edit_for :index, :info
    in_place_edit_for :index, :bind_domain


  def show
    @posts = @index.posts.paginate :per_page => 30, :page => params[:page]
  end

  def settings
    @index_theme_list = IndexTheme::LIST
    @overlap = {}
    get_index_sidebars
  end

  def save_avatar
    file = params[:file] && params[:file][:data]
    if file.respond_to?('content_type')  && file.content_type =~ /^image/ && file.length < 204800
	@index.avatar = file
	notice_stickie t(:avatar_uploaded, :scope => [:txt, :controller, :admin, :indices])
    else
	error_stickie t(:avatar_format_error, :scope => [:txt, :controller, :admin, :indices])
    end
    redirect_to :action => "settings"
  end

  def change_settings
    return unless request.post?
    notice_stickie(t(:config_updated, :scope => [:txt, :controller, :admin, :base])) if @index.update_attributes(params[:index])
    redirect_to :action => "settings"
  end

  def sidebar_position
    get_index_sidebars
    for field in params[:fields]
      next unless params[field.to_sym]
      params[field.to_sym].each_with_index do |id,idx| 
	bar = @all_bars.detect{|s| s.id==id.to_sym}
	bar.position = idx
	bar.field = field
	bar.show = (field.to_sym != :disable)
      end
    end
    notice_stickie(t(:sidebars_updated, :scope => [:txt, :controller, :admin, :sidebar])) if @index.update_attributes(params[:index])
    redirect_to :action => "settings"
  end

  def index
    @indices = Index.find(:all)
  end

  def create
    @index = Index.new(params[:index])
    if @index.save
	render :update do |page|
	    page.insert_html :top, "all_indices", :partial => "index" 
	    page.visual_effect :highlight, "index_#{@index.id}", :startcolor => '#ffff00',
			       :endcolor => '#ffffff',
			       :duration => 5.0
	end
    else
	error_stickie @index.errors.full_messages
 	render :update do |page|
 	  page.replace_html "updater", :partial => "share/error" 
	  page.visual_effect :BlindDown, "updater"
         end
    end

  end

  def add_manager
    @index = Index.find(params[:id])
    user = User.find_by_name(params[:user_name])
    if user && @index.users << user
        render :update do |page|
            page.replace_html "index_users_#{@index.id}", :partial => "managers"
	    page.visual_effect :highlight, "index_#{@index.id}", :startcolor => '#ffff00',
			       :endcolor => '#ffffff',
			       :duration => 5.0
        end
    else
	error_stickie t(:no_such_user, :scope => [:txt, :controller, :admin, :indices])
 	render :update do |page|
 	  page.replace_html "updater", :partial => "share/error" 
	  page.visual_effect :BlindDown, "updater"
         end
    end
  end

  def remove_manager
    @index = Index.find(params[:id])
    user = User.find(params[:user_id])
    if user && @index.users.delete(user)
        render :update do |page|
            page.replace_html "index_users_#{@index.id}", :partial => "managers"
	    page.visual_effect :highlight, "index_#{@index.id}", :startcolor => '#ffff00',
			       :endcolor => '#ffffff',
			       :duration => 5.0
        end
    else
	error_stickie t(:no_such_user, :scope => [:txt, :controller, :admin, :indices])
 	render :update do |page|
 	  page.replace_html "updater", :partial => "share/error" 
	  page.visual_effect :BlindDown, "updater"
         end
    end
  end

  def destroy
    index = Index.find(params[:id])
    notice_stickie t(:index_deleted, :scope => [:txt, :controller, :admin, :indices]) if index.destroy 
    redirect_to admin_indices_path
  end

end
