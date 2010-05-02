class Admin::SidebarController <  Admin::BaseController
  self.prepend_view_path(UserTheme::PATH) 

  def index
    @overlap = {}
    get_sidebars
  end

  def sidebar_postion
    get_sidebars
    for field in params[:fields]
      next unless params[field.to_sym]
      params[field.to_sym].each_with_index do |id,idx| 
	bar = @all_bars.detect{|s| s.id==id.to_sym}
	bar.position = idx
	bar.field = field
	bar.show = (field.to_sym != :disable)
      end
    end
    update_user_and_redirect_to :index, t(:sidebars_updated, :scope => [:txt, :controller, :admin, :sidebar])
  end

end
