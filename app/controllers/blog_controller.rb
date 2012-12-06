class BlogController < ApplicationController
    self.prepend_view_path(UserTheme::PATH) 
    before_filter :get_user_and_needed , :except => [:plugin_css, :favicon]
    before_filter :get_user, :only => [:plugin_css, :favicon]
    include BlogControllerPlugin
    #protect_from_forgery  :only => [:add, :login]

  def guestbook
    @comments = @user.messages unless chito_cache_enable(:id => :guestbook)
    @comment = Feedback.new
  end

  def index
    respond_to do |format|
        format.html
        format.rss do
            @posts = Article.new_posts 
        end
    end
  end

  def add
    unless @site.mutli_users? and @site.registerable?
        error_stickie t(:message_0, :scope => [:txt, :controller, :blog])
    else
        @new_user = User.new
        if request.post?
            if simple_captcha_valid?
                @new_user = User.new(params[:new_user])
                if @new_user.save
                    notice_stickie t(:message_1, :scope => [:txt, :controller, :blog])
                    redirect_to(login_path) 
                end
            else
                @new_user = User.new(params[:new_user])
                error_stickie t(:message_2, :scope => [:txt, :controller, :blog])
            end
        end
    end
  end

  def login
    if request.get?
        session[:jump] = params[:jump]
    elsif request.post?
        user = User.login(params[:name], params[:password])
        if user
            jump = session[:jump]
            clean_session_cookie
            user.set_session(session, request, @site)
            user.remember_me(cookies, request) if params[:persist]
            user.update_attribute(:last_logined_in_at, Time.now)
            if jump
                redirect_to(jump)
            elsif request.domain == @site.domain
                redirect_to admin_url(:subdomain => session[:user_name]) 
            else
                redirect_to(admin_url)
            end
        else
            error_stickie t(:message_3, :scope => [:txt, :controller, :blog])
        end
    end
  end  

  def forgot_password
    return unless request.post?
    user = User.find_by_email(params[:email])
    if user
        user.forgot_password(request)
        notice_stickie t(:reset_password_email_send, :scope => [:txt, :controller, :blog])
    else
        error_stickie t(:no_user_found, :scope => [:txt, :controller, :blog])
    end
  end

  def reset_password
    return unless request.post?
    user = User.find_by_reset_password_key(params[:key])
    if user && user.reset_password_key_expires_at > Time.now
        if params[:new] == params[:_new]
            user.password = params[:new]
            user.reset_password_key = nil
            user.save
            notice_stickie t(:password_reseted, :scope => [:txt, :controller, :blog])
        else
            error_stickie t(:confirm_dismatch, :scope => [:txt, :controller, :blog])
        end    
    else
        error_stickie t(:reset_password_expired, :scope => [:txt, :controller, :blog])
    end 
  end

  def plugin_css
    @plugin_css = ''
    @plugin_css += "\na.comments{display:none;}\n" if @user.comment_system == "disqus"
    do_something :in_plugin_css
    send_data @plugin_css, :type => 'text/css', :disposition => 'inline'   
  end  

  def ajax_simple_captcha
    @theme = nil
    render :partial => 'simple_captcha/simple_captcha_ajax'
  end

  protected

  def render(options = {}, extra_options = {}, &block)
    if @theme and (params[:format].nil? or params[:format] == "html")
        layout = "#{@theme}/layouts/#{@theme}"
        layout_path = File.join(@user.base_dir, "themes", @theme, "layouts", @theme + ".html.erb")
        if File.exists?(layout_path)
            @user_theme = true
        end
        template = "#{controller_name}/#{action_name}"
        theme_template = "#{@theme}/views/#{template}"
        theme_template_path = File.join(UserTheme::PATH, theme_template + ".html.erb" )
        if File.exists?(theme_template_path)
            super :template => theme_template, :layout => layout
        else
            super :template => options[:template] || template, :layout => layout
        end 
    else
        super
    end
  end

end

