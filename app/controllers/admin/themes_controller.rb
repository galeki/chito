class Admin::ThemesController <  Admin::BaseController

  def index
    @theme_list = Theme::THEME_LIST
  end

  def change_theme
    return unless request.post?
    @user.update_attributes(:theme => params[:theme])
    render :partial => 'theme_demo'	
  end

end
