class Admin::DashboardController <  Admin::BaseController
    
    def index
        get_dashboardbars
        do_something :before_admin_dashboard_show
    end

    def dashboardbar_position
        get_dashboardbars
        for field in params[:fields]
            next unless params[field.to_sym]
            params[field.to_sym].each_with_index do |id,idx| 
                bar = @all_bars.detect{|s| s.id==id.to_sym}
                bar.position = idx
                bar.field = field
                bar.show = (field.to_sym != :disable)
            end
        end
        @user.has_dashboard_settings = true
        @user.save && redirect_to(:action => "index")
    end

    def logout
        logout_and_redirect_to
    end
end
