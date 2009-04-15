module BlogHelper
    include BlogHelperPlugin
    
    def header(options={})
	render :partial => 'blog/header', :locals => {:options => options}
    end

    def footer
	%Q?&copy; <a href="http://#{@site.url || request.domain || request.host}">#{@site.title}</a> All rights reserved. | Power by <a href="http://www.chitolog.org">Chito #{VER}</a>  | ? +
	link_to("沪ICP备07005989号", "http://www.miibeian.gov.cn" , :target => "_blank")
    end

    def posts_rss_link
	auto_discovery_link_tag :rss, formatted_posts_url(:rss) , :title => 'Blog RSS'
    end

    def comments_rss_link
	auto_discovery_link_tag :rss, formatted_comments_url(:rss) , :title => 'Comments RSS'
    end

    def messages_rss_link
	auto_discovery_link_tag :rss, formatted_messages_url(:rss) , :title => 'Messages RSS'
    end

    def site_title
	link_to @user.title, :controller => 'posts', :action => 'index'	
    end

    def site_slogan
	@user.slogan
    end

    def blog_tail
	show_something :in_blog_tail
    end
end
