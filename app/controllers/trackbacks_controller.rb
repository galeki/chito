class TrackbacksController < ApplicationController
    before_filter :get_user
    skip_before_filter :verify_authenticity_token


    def create
	if @user.enable_trackbacks
	    @trackback = @user.trackbacks.new
	    @trackback.prepare_trackback(request, params)
	    @error_message = "Trackback not save" unless @trackback.save
	end

	respond_to do |format|
	    format.xml  
	    format.html { render :nothing => true }
	end
    end

end
