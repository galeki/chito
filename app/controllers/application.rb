class ApplicationController < ActionController::Base
    include ApplicationPlugin
    include SimpleCaptcha::ControllerHelpers
    before_filter :get_site
    protect_from_forgery :secret => "d81237377dsbbasd88a3e[e5e6brt4b0d3255bfef9dew890afdqaz"    
    self.prepend_view_path(ChitoPlugin::PLUGIN_PATH) 
    self.prepend_view_path(Theme::THEME_PATH) 
    helper :all
    helper_method :chito_cache_key
    helper_method :'_params'
    #rescue_from(ActiveRecord::RecordNotFound) { error t("txt.errors.404.title1") }
    #rescue_from(NoMethodError) { error t("txt.errors.404.title2") }

    def _params
	params.reject {|k,v| k =~ /action|controller/}
    end

    def admin_authorize
	return if (session[:user_id] && @user = User.find(session[:user_id]))
	if cookies[:remember_key] and @user = User.find_by_remember_key(cookies[:remember_key]) and @user.remember_key_expires_at > Time.now
	    @user.set_session(session, request, @site)
	else
	    redirect_to(login_path :subdomain => "www")
	    return false
	end 
    end

    def chito_admin_authorize
	return if @user.is_chito_admin?
	redirect_to login_path
    end

    def url_for(options = {}, *params)
     if options[:subdomain] && request.domain && @site.mutli_users?
       options[:only_path] = false
       host = []
       host << options.delete(:subdomain)
       host << request.subdomains[1..-1] if request.subdomains.size > 1
       host << (@site.domain || request.domain)
       options[:host] = host.join '.'
     else
       options.delete(:subdomain)
     end
     return super(options, *params)
    end

    def chito_cache_enable(options={}, &block)
	read_fragment chito_cache_key(options), &block
    end

    def sidebar_cache_enable(id, options={}, &block)
	read_fragment chito_cache_key(options.merge(:part => :plugins, :type => :sidebars, :id => id)), &block 
    end

    def chito_cache_expire(options={})
	key = chito_cache_key(options)
	key = Regexp.new(key) if key =~ /\*$/
	expire_fragment key
    end

    def sidebar_cache_expire(id, options={})
	expire_fragment chito_cache_key(options.merge(:part => :plugins, :type => :sidebars, :id => id)) 
    end

    def chito_cache_key(options={})
	key = "#{@user.name}/#{options.delete(:part) || 'blog'}/#{options.delete(:type) || 'main'}"
	key << "/#{options.delete(:id)}" unless options[:id].blank?
	key << "/#{options.to_param}" unless options.blank?
	key
    end

    private

    def if_html
	yield if (params[:format].nil? || params[:format] == "html")
    end
    
    def error(message, options={})
	@message = message
	render :template => 'site/error', :layout => 'site', :status => options[:status] || 404
    end

    def logout_and_redirect_to
	reset_session
	clean_session_cookie 
	notice_stickie t(:message_0, :scope => [:txt, :controller, :application])
	redirect_to login_path
    end
    
    def clean_session_cookie
	cookies.delete :remember_key 
	@user.update_attribute(:remember_key, "")
    end
    
    def get_locale
	I18n.locale = params[:local] || @user.language || "en-US"
    end

    def get_site
	@site = Site.instance
	ActionController::CgiRequest::DEFAULT_SESSION_OPTIONS.update( :session_domain => request.domain)
	unless @site
	    redirect_to :controller => "site", :action => "setup"
	    return false
	end
    end

    def get_user
	@user = @site.get_user(request)
	do_something :after_get_user
    end

    def get_user_and_needed
	get_user
	get_locale
	get_theme
	get_sidebars
	get_navbars
	get_title
	do_something :before_blog_show
    end

    def get_theme
	@theme = @user.theme
	prepend_view_path File.join(@user.base_dir, "themes")
    end

    def get_title
	@titles = [@user.title]
	@titles << @user.slogan if @user.show_slogan_in_title
    end

    def get_sidebars
	if_html do 
	    Sidebar.user = @user
	    do_something :in_sidebar if Sidebar.sidebars.empty?
	    @all_bars = Sidebar.sidebars
	    @enable_bars = @all_bars.select{|b| b.show?}.sort_by{|b| b.position}
	end
    end

    def get_postbars
	if_html do 
	    Postbar.user = @user
	    do_something :in_postbar if Postbar.postbars.empty?
	    @all_postbars = Postbar.postbars
	    @enable_postbars = @all_postbars.select{|b| b.show?}.sort_by{|b| b.position}
	end
    end

    def get_navbars
	if_html do 
	    Navbar.user = @user
	    do_something :in_navbar if Navbar.navbars.empty?
	    @navbars = Navbar.navbars.dup
	    @pages = @user.pages
	    @pages.each do |p|
		navbar = Navbar.new(p)
		@navbars << navbar
	    end
	    @enable_navbars = @navbars.select{|n| n.show?}.sort_by{|n| n.position}
	end
    end
    
    def get_comment_filters
	CommentFilter.user = @user
	do_something :in_comment_filter if CommentFilter.filters.empty?
	@filters = CommentFilter.filters.sort_by {|x| x.position }
    end

end
