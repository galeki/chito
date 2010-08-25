module ApplicationPlugin
    private
    
    def find_official_posts_before_admin_dashboard_show
	@notices = []
	of = User.find_by_name('official')
	@notices = of.posts.order('created_at desc').limit(4) if of
    end
end

bar = Dashboardbar.new
bar.id = :dashboard_official
bar.info = 'Official Updates'
bar.plugin_id = :official_dashboardbar
bar.config = false
bar.default_position = 1
Dashboardbar.add(bar)
