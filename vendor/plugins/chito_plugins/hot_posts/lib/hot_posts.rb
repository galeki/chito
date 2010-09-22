bar = Sidebar.new
bar.id = :hot_posts
bar.config = true
bar.info = 'Hot Posts'
bar.default_position = 100
bar.plugin_id = :hot_posts
Sidebar.add(bar)

module BlogControllerPlugin
  private
  def get_hot_posts_before_blog_show
     if @user.show_hot_posts
         @hot_posts = @user.posts.order('read_count DESC').limit(@user.hot_posts_num.to_num(5))
     end
  end
end
