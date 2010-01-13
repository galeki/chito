module ApplicationPlugin
    private

  def add_akismet_filter_in_comment_filter
    filter = CommentFilter.new(:akismet, 'Akismet', 'call_akismet')
    filter.config = true
    filter.plugin_id = :akismet_comment_filter
    CommentFilter.add(filter)
  end

end


module CommentControllerPlugin
  private
  
  def call_akismet
    if @user.akismet_api_key.blank?
	block_filter :type => :error, 
		     :message => t("plugins.akismet_comment_filter.setup_api_key"),
		     :by => "Akismet" 
    end
	
    attributes = {
	:key => @user.akismet_api_key, #"7d51cbe557f6"
	:blog => request.protocol + request.host_with_port,
	:user_ip => @comment.ip,
	:user_agent => @comment.user_agent,
	:referrer => @comment.referer,
	:comment_author => @comment.writer,
	:comment_author_email => @comment.email,
	:comment_author_url => @comment.homepage,
	:comment_content => @comment.content
    } 
    if Akismetor.spam?(attributes)
	block_filter :type => :warning, 
		     :message => t("plugins.akismet_comment_filter.comment_was_blocked"), 
		     :by => "Akismet" 
    end
  end

end
