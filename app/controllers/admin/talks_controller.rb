class Admin::TalksController < Admin::BaseController

    def index
        @talks = @user.find_talks :page => params[:page]
        @user.has_new_talk = false
        @user.save
    end
end
