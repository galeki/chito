bar = Sidebar.new
bar.id = :random_posts
bar.info = "Random Posts"
bar.config = true
bar.default_position = 100
bar.plugin_id = :random_posts
Sidebar.add(bar)

module BlogControllerPlugin
  private
  def get_random_posts_before_blog_show
    if @user.show_random_posts
        if ActiveRecord::Base.connection.class.to_s =~ /Mysql/ # MYSQL use RAND()
            @random_posts = Article.where("articles.user_id = ? and articles.bit_opt = 0", @user.id).order('rand()').limit(@user.random_posts_num.to_num(5))
        else #PostgreSQL and SQLite use RANDOM()
            @random_posts = Article.where("articles.user_id = ? and articles.bit_opt = 0", @user.id).order('random()').limit(@user.random_posts_num.to_num(5))
        end
    end
  end
end
