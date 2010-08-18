bar = Postbar.new 
bar.id = :relative_posts
bar.info = 'Relative Posts'
bar.plugin_id = :relative_posts
bar.config = true
bar.default_position = 10
Postbar.add(bar)

bar = Postbar.new 
bar.id = :global_relative_posts
bar.info = 'Global Relative Posts'
bar.plugin_id = :relative_posts
bar.config = true
bar.default_position = 12
Postbar.add(bar)


module ApplicationPlugin
	private

	def get_relative_posts_before_post_show
	    if @post
		tag_list = @post.tag_list * ","
                if tag_list.blank?
                    @relative_posts = []
                    @global_relative_posts = []
                else
		    @relative_posts = @user.posts.where("articles.id != ?", @post.id).tagged_with(tag_list, :any => true).limit(@user.local_relative_posts_num.to_num(5)).order('created_at desc')
		    @global_relative_posts = Article.where("articles.bit_opt = 0 and articles.user_id != ?", @post.user_id).tagged_with(tag_list, :any => true).limit(@user.global_relative_posts_num.to_num(5)).order('created_at desc')
                end
	    end
	end


end
module Admin::ArticleControllerPlugin
    private
    def cut_tag_list_before_article_save
        #tag_list = @article.tag_list
        #@article.tag_list = tag_list[1..8] if tag_list
    end
end
