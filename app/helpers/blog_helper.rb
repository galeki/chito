module BlogHelper
    include BlogHelperPlugin
    
    def header(options={})
        render :partial => 'blog/header', :locals => {:options => options}
    end

    def favicon_url
        root_url + "user_files/#{@user.name}/config/favicon.ico"
    end

    def footer
        rewriter { @site.footer.to_s.html_safe }
    end
    
    def posts_rss_link
        auto_discovery_link_tag :rss, posts_url(:format => :rss) , :title => 'Blog RSS'
    end

    def site_rss_link
        auto_discovery_link_tag :rss, site_url(:format => :rss) , :title => "#{@site.title} RSS"
    end

    def index_rss_link
        auto_discovery_link_tag :rss, index_feed_url , :title => "#{@index.title} RSS"
    end

    def comments_rss_link
        auto_discovery_link_tag :rss, comments_url(:format => :rss) , :title => 'Comments RSS'
    end

    def messages_rss_link
        auto_discovery_link_tag :rss, messages_url(:format => :rss) , :title => 'Messages RSS'
    end

    def site_title
        link_to @user.title, root_path
    end

    def site_slogan
        @user.slogan.to_s.html_safe
    end

    def blog_tail
        render :partial => 'blog/tail'
    end
end
