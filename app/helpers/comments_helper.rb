module CommentsHelper

    def comments
        render :partial => 'comments/comments'
    end

    def post_comments
        if @user.comment_system == 'disqus'
            render :partial => 'comments/disqus_comment'
        else
            render :partial => "comments/chito_comment"
        end
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
        @comment.writer
    end

    def link_to_comment_writer
        comment_homepage ? 
                link_to(comment_writer, comment_homepage) :
                comment_writer
    end

    def comment_time
        link_to rewriter{l @comment.created_at}, "#comment#{@comment.id}" 
    end

    def comment_class
        t = "comment_box comment_box#{cycle('0', '1')}"
        t << " comment_self" if @comment.user_name && @comment.user_name.downcase == request.subdomains.first
        t << " comment_reply" if @comment.reply_to.to_i != 0
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

    def comment_reply_id
        "reply_id='#{@comment.reply_to}'" if @comment.reply_to.to_i != 0
    end

    def comment_content_id
        "comment_content#{@comment.id}"
    end

    def comment_content
        @comment.mode == 'plain' ? content = simple_format(h(@comment.content)) : content = @comment.content
        sanitize(content)
    end

    def comment_brief(comment=@comment, options={})
        text = comment.writer + ":" + comment.content.to_s
        if comment.mode == 'plain'
            text = truncate(text, :length => options[:length])
        else
            text = strip_tags(text)
            text = truncate(text, :length => options[:length]).html_safe
        end
        text
    end

    def render_comment
        render :partial => 'comments/comment'
    end

    def reply_comment_button
        content_tag :span, :class => "reply_comment_button" do
            reply_js_function = @user.enable_thread_comment ? "reply_to_id('#{@comment.id}')" : "reply_to('#{comment_writer}', '#{@comment.id}')"
            link_to  t("txt.helper.comments.reply"), "#", :onclick => "#{reply_js_function};event.returnValue = false;return false;",
                     :title => t("txt.helper.comments.reply_to", :user => @comment.writer)
        end
    end

    def mark_spam_comment_button
        content_tag :span, :class => "mark_spam_comment_button", :style => "display:none;" do
            link_to  t("txt.helper.comments.mark_as_spam"), mark_comment_as_spam_path(@comment, :format => :js), 
                     :remote => true, :method => :post,
                     :title => t("txt.helper.comments.mark_as_spam")
        end
    end

    def twitter_comment_button
        unless @comment.twitter.blank?
            content_tag :span, :class => "twitter_comment_button" do
                link_to "", "http://twitter.com/#{h @comment.twitter}", :class => "follow_him", :target => "_blank"
            end
        end
    end

    def thread_comment_script_tag
        if @user.enable_thread_comment && @user.comment_system != 'disqus'
           javascript_tag "thread_comment();"
        end
    end
end
