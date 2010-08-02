    module BlogControllerPlugin
      private
      def get_tag_cloud_before_blog_show
	    if @user.show_tag_cloud && !sidebar_cache_enable(:tag_cloud)
		@tags = @user.posts.tag_counts
	    end
      end
    end
    module ApplicationPlugin
	private
	def add_tag_cloud_in_sidebar
	    bar = Sidebar.new
	    bar.id = :tag_cloud
	    bar.info = 'Tag Cloud'
	    bar.config = true
	    bar.default_position = 80
	    bar.plugin_id = :tag_cloud
	    Sidebar.add(bar)
	end
	def default_tag_cloud_css
	    %Q~#tag_cloud{padding:5px 20px 0px 20px;}
.tag_css1 { font-size: 8px; }
.tag_css2 { font-size: 12px; }
.tag_css3 { font-size: 16px; }
.tag_css4 { font-size: 24px; }
~
	end
	def add_tag_cloud_css_in_plugin_css
	    @user.tag_cloud_css ||= default_tag_cloud_css
	    @plugin_css << @user.tag_cloud_css
	end
    end

    module Admin::ArticleControllerPlugin
	private
	def expire_tag_cloud_before_article_save
	    unless @article.tag_list.blank?
		sidebar_cache_expire :id => :tag_cloud
	    end
	end
    end
