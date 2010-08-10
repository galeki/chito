class Admin::SettingsController < Admin::BaseController

  def info
    return unless request.post?
    if @user.update_attributes(params[:user])
        notice_stickie t(:profile_updated, :scope => [:txt, :controller, :admin, :settings])
    else
        error_stickie @user.errors.full_messages * "; "
    end
    redirect_to :action => 'info'
  end

  def blog
    return unless request.post?
    update_user_and_redirect_to :blog
  end

  def admin_style
    return unless request.post?
    @user.admin_style = params[:user][:admin_style]
    @user.save
    redirect_to :action => 'system'
  end

  def avatar_info
    return unless request.post?
    update_user_and_redirect_to :info
  end

  def save_avatar
    file = params[:file] && params[:file][:data]
    if file.respond_to?('content_type')  && file.content_type =~ /^image/ && file.length < 204800
	@user.avatar = file
	notice_stickie t(:avatar_uploaded, :scope => [:txt, :controller, :admin, :settings])
    else
	error_stickie t(:avatar_format_error, :scope => [:txt, :controller, :admin, :settings])
    end
    redirect_to :action => "info"
  end

  def save_favicon
    file = params[:file] && params[:file][:data]
    if file.respond_to?('content_type')  && file.content_type =~ /^image/ && file.length < 20480
	@user.favicon = file
	notice_stickie t(:favicon_uploaded, :scope => [:txt, :controller, :admin, :settings])
    else
	error_stickie t(:favicon_format_error, :scope => [:txt, :controller, :admin, :settings])
    end
    redirect_to :action => "info"
  end

  def change_password
    old, new, _new = params[:old], params[:new], params[:_new]
    if new == _new 
        if @user.hashed_password == User.hash_password(old, @user.salt)
	    @user.password = new
	    notice_stickie t(:password_updated, :scope => [:txt, :controller, :admin, :settings]) if @user.save
	else
	    error_stickie t(:password_invalid, :scope => [:txt, :controller, :admin, :settings])
	end
    else
        error_stickie t(:password_dismatch, :scope => [:txt, :controller, :admin, :settings])
    end
    redirect_to :action => 'system'
  end

  def system
  end

end
