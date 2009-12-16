class Admin::ThemesController <  Admin::BaseController

  def index
    @theme_list = Theme.user_themes(@user) + Theme::THEME_LIST
    @user_theme_count = Theme.user_themes(@user).size
    @theme_list.uniq!
  end

  def change_theme
    return unless request.post?
    @user.update_attributes(:theme => params[:theme], :user_theme => params[:user_theme])
    render :partial => 'theme_demo'	
  end

end
