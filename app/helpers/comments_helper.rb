module CommentsHelper

    def comments
	render :partial => 'comments/comments'
    end

    def all_comments
	@no = (1..@comments.size).to_a
	@no.reverse! unless controller.action_name == "guestbook"
	for @comment in @comments
	    yield
	end
	@comment = nil
    end

    def comment_writer
	h @comment.writer
    end

    def link_to_comment_writer
	comment_homepage ? 
		white_list(link_to comment_writer, comment_homepage) :
		comment_writer
    end

    def comment_time
	link_to rewriter{l @comment.created_at}, "#comment#{@comment.id}" 
    end

    def comment_class
	t = "comment_box comment_box#{cycle('0', '1')}"
	t << " comment_self" if @comment.user_name && @comment.user_name.downcase == request.subdomains.first
	t
    end

    def comment_avatar
	@comment.user_post ? user_avatar : guest_avatar
    end

    def user_avatar
	comment_homepage ? 
		link_to(image_tag(@comment.avatar_url), h(comment_homepage || '')) :
		image_tag(@comment.avatar_url)
    end

    def guest_avatar
	rewriter{ image_tag "/user_files/avatar_small.png" }
    end

    def comment_homepage
	@comment.user_post ? root_url(:subdomain => @comment.user_name) : (@comment.homepage.to_s.to_url)
    end

    def comment_count
	@no.pop.to_s if @no
    end

    def comment_id
	"comment#{@comment.id}"
    end

    def comment_content_id
	"comment_content#{@comment.id}"
    end

    def comment_content
	@comment.mode == 'plain' ? content = simple_format(h(@comment.content)) : content = @comment.content
	white_list (content)
    end

    def render_comment
	render :partial => 'comments/comment'
    end

    def reply_comment_button
	content_tag :span, :class => "reply_comment_button" do
	    link_to_function t("txt.helper.comments.reply"), "reply_to('#{comment_writer}');event.returnValue = false;", :class => "reply_him",
				:title => t("txt.helper.comments.reply_to", :user => @comment.writer)
	end
    end
end
