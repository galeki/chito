class Admin::ThemesController <  Admin::BaseController

  def index
    @theme_list = UserTheme.user_themes(@user) + UserTheme::LIST
    @user_theme_count = UserTheme.user_themes(@user).size
    @theme_list.uniq!
  end

  def change_theme
    return unless request.post?
    @user.update_attributes(:theme => params[:theme], :user_theme => params[:user_theme])
    render :partial => 'theme_demo'	
  end

end
