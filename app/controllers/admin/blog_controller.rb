class Admin::BlogController < Admin::BaseController
    before_filter :chito_admin_authorize
    
    def index
    end
    

    def settings
        get_comment_filters
	return unless request.post?
	@site.update_attributes(params[:site]) ? notice_stickie(t(:config_updated, :scope => [:txt, :controller, :admin, :site])) : 
						 error_stickie(t(:config_not_save, :scope => [:txt, :controller, :admin, :site]))
	redirect_to :action => "index"
    end

end
