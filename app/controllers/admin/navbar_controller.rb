class Admin::NavbarController <  Admin::BaseController

  def index
    get_navbars
    @disable_navbars = @navbars.reject{|n| n.show?}.sort_by{|n| n.position}
  end

  def navbar_position
    return unless request.post?
    get_navbars
    for field in [:enable, :disable]
      next unless params[field]
      params[field].each_with_index do |id,idx| 
	bar = @navbars.detect{|s| s.id == id.to_sym}
	bar.position = idx
	bar.show = (field == :enable)
      end
    end    
    Navbar.user.save
    notice_stickie t(:navbar_updated, :scope => [:txt, :controller, :admin, :navbar])    
    redirect_to :action => "index"
  end

end
