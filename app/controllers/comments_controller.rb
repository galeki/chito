class CommentsController < ApplicationController
     include CommentControllerPlugin
     before_filter :get_user
     before_filter :get_comment_filters, :except => [:index]
    
   def index
	@comments = @user.comments.order('created_at desc').limit(20)
	respond_to {|format| format.rss}
   end

   def create
	@comment = @user.comments.new(params[:comment])
	@comment.prepare(params, request, session, cookies)
        chito_spam_check

	@post = @user.posts.find(params[:post_id])
	@comment.article_id = @post.id
	@no = [@post.comments.count + 1]

	call_filter
	@comment.save 
	@post.update_attribute(:last_commented_at, Time.now)
	sidebar_cache_expire(:new_comments)
	chito_cache_expire(:type => "posts_index/*")
	chito_cache_expire(:type => :posts, :id => :feedbacks, :post => @post.id)
	render_update(:position => :bottom)
	call_notifier

      rescue CommentFilterBlock
	render_error
   end 

   private

   def chito_spam_check
        block_filter(:drop => true) unless params[:comment][:info].blank?
        block_filter(:drop => true) unless params[:comment][:value].blank?
   end

   def call_notifier
	call_talk_notifier
	call_email_notifier
   end

   def call_talk_notifier
	@post.comments.each do |comment|
	    if comment.post_by.to_i > 0 && comment.post_by.to_i != @user.id && comment.post_by != session[:user_id]
		user = User.find(comment.post_by)
		user.update_attribute("has_new_talk", true) if user
	    end
	end
   end

   def call_email_notifier
	@post.emails ||= {}
	if params[:enable_notifier] && !@post.emails.has_key?(@comment.email)
	    @post.emails[@comment.email] = UUIDTools::UUID.random_create.to_s
	    @post.save
	end
	@post.emails.each_key do |email|
            begin
                ChitoMailer.comment_notifier(email, @comment, @post, request).deliver unless email == @comment.email
            rescue
                next #continue deliver remianed email if current deliver failed
            end
	end

   end
   
   def call_filter
	unless @comment.valid?
	    block_filter :type => :error, :message => @comment.errors.full_messages * "; ", :drop => true
	end
	#do_something :before_comment_save
	@filters.each do |f|
	    send(f.hook) if f.enable
	end
   end

   def render_update(options = {})
	render :update do |page|
 	  page.replace_html "comment_error", "" 
          if @user.enable_thread_comment && @comment.reply_to
	    page.insert_html :before, 'post_comment',  :partial => 'comments/comment'
          else
	    page.insert_html options[:position], 'comments',  :partial => 'comments/comment'
          end
	  page.visual_effect :highlight, "comment#{@comment.id}", :duration => 5, :startcolor => '#ffff00'
	  page.call @call if @call
	  page.call 'clean_field'
        end
   end

   def render_error
 	render :update do |page|
 	  page.replace_html "comment_error", :partial => "comments/error" 
	  page.visual_effect :slide_down, "comment_error"
	  page.call @call if @call
         end
   end

   def block_filter(options={})
	 send("#{options[:type]}_stickie", options[:message]) if options[:type] && options[:message]
	 @comment.pass = false
	 @comment.audit_by = options[:by]
	 @comment.save unless options[:drop]
	 unless options[:drop]
            @user.has_new_spam = true 
            @user.save
         end
	 raise CommentFilterBlock
   end

end
