class Admin::FeedbacksController < Admin::BaseController
    #before_filter :chito_admin_authorize    

  def index
    chito_admin_authorize
    @feedbacks = Feedback.paginate :per_page => 30, :page => params[:page], 
                                   :include => [:article, :user],
                                   :order => 'created_at desc'
  end

  def destroy
    chito_admin_authorize
    @feedback = Feedback.find(params[:id])
    notice_stickie t(:feedback_deleted, :scope => [:txt, :controller, :admin, :feedbacks]) if @feedback.destroy
    redirect_to admin_feedbacks_path   
  end
   
  def destroy_selected
        chito_admin_authorize
	destroy_global_ids(params[:ids])
	notice_stickie t(:feedbacks_deleted, :scope => [:txt, :controller, :admin, :feedbacks])
	redirect_to(admin_feedbacks_path :keyword => params[:keyword], :page => params[:page])
  end	

 private    

  def clean_email(comment)
	article = @user.articles.find(comment.article_id) rescue nil
	if article && article.email && article.emails.has_key?(comment.email)
	    article.emails.delete(comment.email)
	    article.save
	end
  end

  def destroy_ids(ids)
	if ids
	    for comment in @user.feedbacks.find(ids)
		clean_email(comment)
		comment.destroy
	    end
	end	
  end

  def destroy_global_ids(ids)
	if ids
	    for feedback in Feedback.find(ids)
		clean_email(feedback)
		feedback.destroy
		end
	end
  end
	    
end
