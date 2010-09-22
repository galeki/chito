class SiteController < ApplicationController
    skip_before_filter :get_site


    def setup
        @site = Site.instance
        raise if @site
        I18n.locale = params[:local] || "en-US"
        @user = User.new
        return unless request.post?
        #I18n.locale = params[:local] || "en-US"
        @user = User.new(params[:user])
        Group.init
        @user.group_id = Group.admin.id
        if @user.save
            @site = Site.new(params[:sites])
            @site.default_user = @user.name
            @site.default_group = Group.default.id
            @site.index_mode = "user"
            redirect_to "/" if @site.save
        end

        #rescue 
        #   error t(:message_0, :scope => [:txt, :controller, :site])
    end
    

end
