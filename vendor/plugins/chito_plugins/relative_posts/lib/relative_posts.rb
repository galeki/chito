module ApplicationPlugin
	private

	def get_relative_posts_before_post_show
	    if @post
		tag_list = @post.tag_list * ","
		@relative_posts = @user.posts.find_tagged_with(tag_list, :conditions => ["articles.id != ?", @post.id], :limit => @user.local_relative_posts_num.to_num(5))
		@global_relative_posts = Article.find_tagged_with(tag_list, :conditions => ["articles.bit_opt = 0 and articles.user_id != ?", @post.user_id], :limit => @user.global_relative_posts_num.to_num(5))
	    end
	end

	def add_relative_posts_in_postbar
		bar = Postbar.new 
		bar.id = :relative_posts
		bar.info = 'Relative Posts'
		bar.plugin_id = :relative_posts
		bar.config = true
		bar.default_position = 10
		Postbar.add(bar)
	end
	
	def add_global_relative_posts_in_postbar
		bar = Postbar.new 
		bar.id = :global_relative_posts
		bar.info = 'Global Relative Posts'
		bar.plugin_id = :relative_posts
		bar.config = true
		bar.default_position = 12
		Postbar.add(bar)
	end
end
    module Admin::ArticleControllerPlugin
	private
 	def cut_tag_list_before_article_save
	    #tag_list = @article.tag_list
	    #@article.tag_list = tag_list[1..8] if tag_list
 	end
    end
