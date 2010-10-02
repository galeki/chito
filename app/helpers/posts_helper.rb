module PostsHelper

    def post_link(post, options={})
        permalink = post.permalink || post.seo_title
        permalink = permalink.blank? ?  nil : permalink.gsub(' ','-').gsub('.','-')
        path = {:controller => "/posts", :subdomain => options[:subdomain],  :action => 'show', :id => post.id, 
                 :format => 'html', :permalink => permalink,:anchor => options.delete(:anchor)}
        path.merge!({:year => post.created_at.year, :month => post.created_at.month, :day => post.created_at.day}) unless permalink.blank?
        link_to options.delete(:text) || post_title(post), path, options
    end 

    def link_to_post(options={})
        post_link(@post, options)
    end

    def pagilinks
        render :partial => 'pagination_links'
    end

    def posts_cache(&block)
         chito_cache _params.merge(:type => :posts_index, :theme => @user.theme), &block
    end

    def posts(&block)
        for @post in @posts
            yield 
        end
    end

    def post_title(post=@post)
        post.title.blank? ? t(:no_title, :scope => [:txt, :helper, :posts]) : post.title
    end

    def post_writer
        rewriter{ @post.writer || @user.nick }
    end

    def post_read_count
        @post.read_count
    end

    def if_my_post(&block)
        with_output_buffer(&block) if session[:user_id] == @post.user_id
    end

    def if_show_trackbacks(&block)
        @trackbacks = @post.trackbacks
        with_output_buffer(&block) if @user.show_trackbacks && @trackbacks.size > 0
    end

    def if_can_comment(&block)
        with_output_buffer(&block) unless @post.forbid_comment || @post.is_draft?
    end

    def post_brief
        arounder{ ("<div class='post_brief'>" + @post.brief.to_s + "</div>").html_safe}
    end

    def link_to_post_category(options={})
        (link_to h(@post.category.name), category_posts_path(@post.category), options) if @post.category
    end

    def link_to_post_tags(options={})
        unless @post.cached_tag_list.blank?
            @post.cached_tag_list.split(', ').inject(""){|html, tag| html << (link_to h(tag), tag_posts_path(tag), options) << '  '}.html_safe
        end
    end

    def link_to_read_more
        if @post.auto_brief
            @post.has_more ? link_to_post(:text => t(:message_0, :scope => [:txt, :helper, :posts]), :anchor => 'more') : ''
        else
            link_to_post(:text => t(:message_1, :scope => [:txt, :helper, :posts]))              
        end
    end

    def post_date
        @post.created_at
    end

    def post_time
        rewriter{l @post.created_at} 
    end

    def link_to_previous_post
        post_link(@previous_post, :title => t(:message_4, :scope => [:txt, :helper, :posts]), :class =>"up") if @previous_post  
    end

    def link_to_next_post
        post_link(@next_post, :title => t(:message_5, :scope => [:txt, :helper, :posts]), :class =>"down") if @next_post        
    end

    def post_content
        arounder{ ("<div id='article_content'>" + @post.content.to_s.sub('<!--more-->','<a id="more"></a>') + "</div>").html_safe }
    end

    def postbars
        render :partial => "postbars"
    end

    def postbars_script_tag
        if @user.show_postbars && @post
            javascript_tag %Q=$(function() {$("#article_tabs").tabs();});=
        end
    end

    def rss_content(post_content)
        arounder{ post_content }
    end

end
