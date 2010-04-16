class Admin::PostbarController <  Admin::BaseController
    
    def index
	get_postbars
	@disable_postbars = @all_postbars.reject{|n| n.show?}.sort_by{|n| n.position}
    end

    def postbar_position
	get_postbars
	for field in [:enable, :disable]
	    next unless params[field]
	    params[field].each_with_index do |id,idx| 
		bar = @all_postbars.detect{|s| s.id==id.to_sym}
		bar.position = idx
		bar.field = field
		bar.show = (field == :enable)
	    end
	end
	update_user_and_redirect_to :index, t(:postbar_updated, :scope => [:txt, :controller, :admin, :postbar])
    end
end
