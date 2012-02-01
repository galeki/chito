class Admin::SpamsController < Admin::CommentsController

    def index
        @spams = @user.find_feedbacks :type => :spams, :keyword => nil,
                                        :per_page => 25, :page => params[:page]
        @user.has_new_spam = false
        @user.save
    end

    def pass
        spam = @user.feedbacks.find(params[:id])
        spam.pass = true
        notice_stickie t(:comment_restored, :scope => [:txt, :controller, :admin, :spams]) if spam.save
        sidebar_cache_expire(:new_comments)
        chito_cache_expire(:type => "posts_index/*")
        chito_cache_expire(:type => :posts, :id => :feedbacks, :post => spam.article_id) if spam.article_id
        redirect_to admin_spams_path :page => params[:page]
    end

    def destroy
        spam = @user.feedbacks.find(params[:id])
        notice_stickie t(:spam_deleted, :scope => [:txt, :controller, :admin, :spams]) if spam.destroy
        redirect_to admin_spams_path :page => params[:page]
    end

    def destroy_selected
        destroy_ids(params[:ids])
        notice_stickie t(:spams_deleted, :scope => [:txt, :controller, :admin, :spams])
        redirect_to admin_spams_path :page => params[:page]
    end     
end
