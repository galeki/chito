class Admin::CommentsController < Admin::FeedbacksController

    def index
        @comments = @user.find_feedbacks :type => :comments, :keyword => params[:keyword],
                                        :per_page => 25, :page => params[:page]
    end

    def destroy
        comment = @user.comments.find(params[:id])
        clean_email(comment)
        notice_stickie t(:comment_deleted, :scope => [:txt, :controller, :admin, :comments]) if comment.destroy
        sidebar_cache_expire(:new_comments)
        chito_cache_expire(:type => "posts_index/*")
        chito_cache_expire(:type => :posts, :id => :feedbacks, :post => comment.article_id) if comment.article_id
        redirect_to(admin_comments_path :keyword => params[:keyword], :page => params[:page])
    end

    def destroy_selected
        destroy_ids(params[:ids])
        notice_stickie t(:comments_deleted, :scope => [:txt, :controller, :admin, :comments])
        sidebar_cache_expire(:new_comments)
        chito_cache_expire(:type => "posts_index/*")
        redirect_to(admin_comments_path :keyword => params[:keyword], :page => params[:page])
    end

end
