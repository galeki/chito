class Admin::TalksController < Admin::BaseController

    def index
	@talks = @user.find_talks :page => params[:page]
	@user.update_attribute("has_new_talk", false)
    end
end
