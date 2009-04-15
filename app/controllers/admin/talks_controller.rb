class Admin::TalksController < Admin::BaseController

    def index
	@talks = @user.find_talks :page => params[:page]
    end
end
