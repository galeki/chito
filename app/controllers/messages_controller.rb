class MessagesController < CommentsController

    def index
        @messages = @user.messages.order('created_at desc').limit(20)
        respond_to {|format| format.rss}
    end

    def create
        @comment = @user.messages.new(params[:comment])
        @comment.prepare(params, request, session, cookies)
        @comment.is_message = true 
        @render_options = {:position => :top}
        call_filter
        @comment.save 
        chito_cache_expire :id => :guestbook, :in => :all
        sidebar_cache_expire :new_messages
        render "comment_update"

      rescue CommentFilterBlock
        render "comment_error"
    end
end
