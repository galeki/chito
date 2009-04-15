class Admin::MessagesController < Admin::CommentsController

    def index
	@messages = @user.find_feedbacks :type => :messages, :keyword => params[:keyword],
					:per_page => 25, :page => params[:page]
    end

    def destroy
        message = @user.messages.find(params[:id])
	notice_stickie t(:message_deleted, :scope => [:txt, :controller, :admin, :messages]) if message.destroy
	sidebar_cache_expire :new_messages
	chito_cache_expire :id => :guestbook
	redirect_to admin_messages_path :keyword => params[:keyword], :page => params[:page]
    end

    def destroy_selected
	destroy_ids(params[:ids])
	notice_stickie t(:messages_deleted, :scope => [:txt, :controller, :admin, :messages])
	sidebar_cache_expire :new_messages
	chito_cache_expire :id => :guestbook
	redirect_to admin_messages_path :keyword => params[:keyword], :page => params[:page]
    end	
end
