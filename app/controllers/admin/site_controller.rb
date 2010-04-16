class Admin::SiteController < Admin::BaseController
    before_filter :chito_admin_authorize
    
    def index
	@site_class = @root = "selected"	
	@groups = Group.find(:all, :conditions => ["name != 'Admin'"])
    end
    

    def config
	return unless request.post?
	if User.find_by_name(params[:site][:default_user])
	    @site.bit_opt_will_change! if @site.respond_to?(:bit_opt_will_change!)
	    @site.update_attributes(params[:site]) ? notice_stickie(t(:config_updated, :scope => [:txt, :controller, :admin, :site])) : 
						     error_stickie(t(:config_not_save, :scope => [:txt, :controller, :admin, :site]))
	else
	    error_stickie t(:no_user, :scope => [:txt, :controller, :admin, :site], :user => "<b>#{params[:site][:default_user]}</b>")
	end
	redirect_to :action => "index"
    end

end
