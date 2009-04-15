class BlogController < ApplicationController
    before_filter :get_user_and_needed , :except => [:plugin_css, :favicon]
    before_filter :get_user, :only => [:plugin_css, :favicon]
    include BlogControllerPlugin
    protect_from_forgery  :only => [:add, :login]

  def guestbook
    @comments = @user.messages unless chito_cache_enable(:id => :guestbook)
    @comment = Feedback.new
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
		    redirect_to(login_path) and return
		end
	    else
		@new_user = User.new(params[:user])
		flash[:error] = t(:message_2, :scope => [:txt, :controller, :blog])
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
	    reset_session
	    user.set_session(session, request, @site)
	    user.remember_me(cookies, request) if params[:persist]
	    if jump
		redirect_to(jump) and return
	    elsif request.domain == @site.domain
		redirect_to admin_url(:subdomain => session[:user_name]) and return
	    else
		redirect_to("/admin") and return
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
	if params[:new]	== params[:_new]
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
    do_something :in_plugin_css
    send_data @plugin_css, :type => 'text/css', :disposition => 'inline'   
  end  

  def favicon
    if File.exists?("#{@user.base_dir}/config/favicon.ico")
	send_file "#{@user.base_dir}/config/favicon.ico", :type => 'image/x-icon', :disposition => 'inline'
    else
	render :text => "No Favicon"
    end
  end

  protected

  def render(options = nil, extra_options = {}, &block)
    if @theme and (params[:format].nil? or params[:format] == "html")
   	layout = "#{@theme}/layouts/#{@theme}"
	template = "#{@theme}/views/#{action_name}"
	template_path = File.join("#{RAILS_ROOT}/themes", template + ".html.erb" )
	if File.exists?(template_path)
	    super :template => template, :layout => layout
	else
	    super :template => options && options[:template], :layout => layout
	end 
    else
	super(options, extra_options, &block)
    end
  end

  #def setup_title
  #  thash = {}
  #  tstring = @user.blog_format_string || "%article_title% !!!!--!!!!! %blog_title%"
  #  article = @post || @page
  #  if article
  #	thash["%article_title%"] = article.title
  #	thash["%article_category%"] = article.category.name if article.category
  #  end
  #	
  #  thash["%blog_title%"] = @user.title
  #  thash["%blog_slogan%"] = @user.slogan
  #  @title = tstring.replace_with(thash)
  #end

end

