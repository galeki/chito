class Admin::IndexSidebarController <  Admin::BaseController
  self.prepend_view_path(IndexTheme::PATH) 
  before_filter :chito_admin_authorize    

  def index
    @index_theme_list = IndexTheme::LIST
    @overlap = {}
    get_index_sidebars
  end

  def change_settings
    return unless request.post?
    notice_stickie(t(:config_updated, :scope => [:txt, :controller, :admin, :base])) if @site.update_attributes(params[:site])
    redirect_to :action => "index"
  end

  def sidebar_postion
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
    notice_stickie(t(:sidebars_updated, :scope => [:txt, :controller, :admin, :sidebar])) if @site.update_attributes(params[:site])
    redirect_to :action => "index"
  end

end
