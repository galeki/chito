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
    if file.respond_to?('content_type')  && file.content_type =~ /^image/ && file.size < 204800
        @user.avatar = file
        notice_stickie t(:avatar_uploaded, :scope => [:txt, :controller, :admin, :settings])
    else
        error_stickie t(:avatar_format_error, :scope => [:txt, :controller, :admin, :settings])
    end
    redirect_to :action => "info"
  end

  def save_favicon
    file = params[:file] && params[:file][:data]
    if file.respond_to?('content_type')  && file.content_type =~ /^image/ && file.size < 20480
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

  def comment

  end

    def comment_setting_area
        system = params[:system] || @user.comment_system
        if system == 'disqus'
            @area = 'disqus_comment_settings'
        else
            get_chito_comment_system_settings
            @area = 'chito_comment_settings'
        end
    end

    def set_comment_system_settings
        get_comment_filters
        for field in ["enable_filters", "disable_filters"]
            next unless params[field.to_sym]
            params[field.to_sym].each_with_index do |id,idx| 
                bar = @filters.detect{|s| s.id == id.to_sym}
                bar.position = idx
                bar.enable = (field.to_sym == :enable_filters)
            end
        end
        @user.update_attributes(params[:user])
        notice_stickie t(:filter_settings_updated, :scope => [:txt, :controller, :admin, :comments])
        redirect_to :action => "comment"
    end

    private

    def get_chito_comment_system_settings
        get_comment_filters
        @enable_filters, @disable_filters = @filters.separate {|x| x.enable}
    end
end
