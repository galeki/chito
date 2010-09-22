class Admin::TrackbacksController < Admin::CommentsController

    def index
        @trackbacks = @user.find_feedbacks :type => :trackbacks, :keyword => params[:keyword],
                                        :per_page => 25, :page => params[:page]
    end

    def destroy
        trackback = @user.trackbacks.find(params[:id])
        notice_stickie t(:trackback_deleted, :scope => [:txt, :controller, :admin, :trackbacks]) if trackback.destroy
        redirect_to admin_trackbacks_path :keyword => params[:keyword], :page => params[:page]
    end

    def destroy_selected
        destroy_ids(params[:ids])
        notice_stickie t(:trackbacks_deleted, :scope => [:txt, :controller, :admin, :trackbacks])
        redirect_to admin_trackbacks_path :keyword => params[:keyword], :page => params[:page]
    end 
end
