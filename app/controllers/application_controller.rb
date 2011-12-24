class ApplicationController < ActionController::Base
    include ApplicationPlugin
    include SimpleCaptcha::ControllerHelpers
    before_filter :get_site
    self.prepend_view_path(ChitoPlugin::PLUGIN_PATH) 
    helper :all
    include Chito::CacheController
    helper_method :chito_cache_key
    helper_method :'_params'
    helper_method :url_for
    helper LaterDude::CalendarHelper
    #rescue_from(ActiveRecord::RecordNotFound) { error t("txt.errors.404.title1") }
    #rescue_from(NoMethodError) { error t("txt.errors.404.title2") }

    def _params
        params.reject {|k,v| k =~ /action|controller/}
    end

    def admin_authorize
        if session[:user_name]
            @user = User.find_by_name(session[:user_name])
            return if @user
        end
        if cookies[:remember_key] 
            @user = User.find_by_remember_key(cookies[:remember_key])
            if @user && @user.remember_key_expires_at > Time.now
                @user.set_session(session, request, @site) 
                return
            end
        end
        
        redirect_to(login_path(:subdomain => "www"))
    end

    def admin_subdomain_check
        if request.domain == @site.domain && @site.mutli_users? && session[:user_name].to_s.downcase != request.subdomains.first
            redirect_to(:subdomain => session[:user_name])
        end
    end

    def chito_admin_authorize
        return if @user.is_chito_admin?
        redirect_to login_path
    end

    def index_manager_authorize
        @index = Index.find(params[:id])
        return if @index and @user.indices.find(@index.id)
        redirect_to login_path
    end

    def url_for(options = nil)
        if options.is_a?(Hash) && options[:subdomain]
            if request.domain && @site.mutli_users?
                host = []
                host << options.delete(:subdomain)
                host << request.subdomains[1..-1] if request.subdomains.size > 1
                host << (@site.domain || request.domain)
                options[:host] = host.join('.')
            else
                options.delete(:subdomain) 
            end
        end
        super
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

    def get_time_zone
        Time.zone = @site.default_time_zone || "UTC"
        Time.zone = @user.time_zone if @user && @user.time_zone
    end

    def get_site
        @site = Site.instance
        @now = Time.now
        unless @site
            redirect_to :controller => "site", :action => "setup"
            return false
        end
    end

    def get_user
        @user = @site.get_user(request)
        @user.enable_comment_filter_simple_vcode = @site.force_comment_captche
        #do_something :after_get_user
    end

    def get_user_and_needed
        get_user
        get_locale
        get_time_zone
        get_theme
        if_html do
            get_sidebars
            get_navbars
        end
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
        Sidebar.user = @user
        @all_bars = Sidebar.sidebars
        @enable_bars = @all_bars.select{|b| b.show?}.sort_by{|b| b.position}
    end

    def get_index_sidebars
        IndexSidebar.user = @index
        @all_bars = IndexSidebar.index_sidebars
        @enable_bars = @all_bars.select{|b| b.show?}.sort_by{|b| b.position}
    end

    def get_dashboardbars
        @user.set_default_dashboard_settings unless @user.has_dashboard_settings
        Dashboardbar.user = @user
        @all_bars = Dashboardbar.dashboardbars
        @enable_bars = @all_bars.select{|b| b.show?}.sort_by{|b| b.position}
        @disable_bars = @all_bars.reject {|b| b.show?}
    end

    def get_postbars
        Postbar.user = @user
        @all_postbars = Postbar.postbars
        @enable_postbars = @all_postbars.select{|b| b.show?}.sort_by{|b| b.position}
    end

    def get_navbars
        Navbar.user = @user
        @navbars = Navbar.navbars.dup
        @pages = @user.pages
        @pages.each do |p|
            navbar = Navbar.new(p)
            @navbars << navbar
        end
        @enable_navbars = @navbars.select{|n| n.show?}.sort_by{|n| n.position}
    end
    
    def get_comment_filters
        CommentFilter.user = @user
        @filters = CommentFilter.filters.sort_by {|x| x.position }
    end

end
