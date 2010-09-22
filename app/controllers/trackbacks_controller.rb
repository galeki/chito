class TrackbacksController < ApplicationController
    before_filter :get_user
    skip_before_filter :verify_authenticity_token


    def create
        @error_message = "Trackback not save"
        if false && @user.enable_trackbacks #TODO Disable for no spam protection
            post = @user.posts.find(params[:post_id])
            if post && post.trackback_key == params[:key]
                @trackback = @user.trackbacks.new
                @trackback.prepare_trackback(request, params)
                @trackback.save && @error_message = ""
                chito_cache_expire(:type => :posts, :id => :feedbacks, :post => post.id)
            end
        end

        respond_to do |format|
            format.xml  
            format.html { render :nothing => true }
        end
    end

end
