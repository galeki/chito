class Admin::ThemesettingsController <  Admin::BaseController

  def index
    prepend_view_path File.join(@user.base_dir, "themes")    
    return unless request.post?
    update_user_and_redirect_to :index
  end

end
