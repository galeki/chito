ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
	#map.root :controller => 'posts', :action => 'index'
	map.connect "/", :controller => 'index', :action => 'index'
	map.index_feed "/index.rss", :controller => 'index', :action => 'index', :format => "rss"
	map.root :controller => 'posts', :action => 'index'
	map.favicon '/favicon.ico', :controller => 'blog', :action => 'favicon'
	map.plugin_css '/plugin.css', :controller => 'blog', :action => 'plugin_css'
#	map.captcha_image '/captcha_image', :controller => 'blog', :action => 'captcha'
	map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
	map.connect '/simple_captcha_ajax', :controller => 'simple_captcha', :action => 'simple_captcha_ajax'

	map.connect "/:year/:month/:day/:permalink.:id.:format", 
		    :requirements => {:year => /(19|20)\d\d/, :month => /[0|1]?\d/, :day => /[0-3]?\d/},
		    :controller => 'posts',
		    :action => 'show'

	map.resources :posts, :has_many => :comments, :member => {:cancel_comment_notifier => :get}
	map.resources :posts, :has_many => :trackbacks
	map.resources :pages
	map.resources :categories, :has_many => :posts
	map.resources :messages
	map.comments '/comments.:format', :controller => 'comments', :action => 'index'
	#map.tag_posts '/tag/:tag_name', :controller => 'posts', :action => 'index'
	map.tag_posts '/tag/*tag_name', :controller => 'posts', :action => 'index'
	#
	
	#In place edit jQuery
	map.connect '/admin/links/set_link_title', :controller => 'admin/links', :action => 'set_link_title'
	map.connect '/admin/links/set_link_url', :controller => 'admin/links', :action => 'set_link_url'
	map.connect '/admin/links/set_link_info', :controller => 'admin/links', :action => 'set_link_info'

	map.connect '/admin/categories/set_category_name', :controller => 'admin/categories', :action => 'set_category_name'
	map.connect '/admin/categories/set_category_info', :controller => 'admin/categories', :action => 'set_category_info'

	map.connect '/admin/users/set_user_bind_domain', :controller => 'admin/users', :action => 'set_user_bind_domain'

	map.connect '/admin/groups/set_group_space', :controller => 'admin/groups', :action => 'set_group_space'
	map.connect '/admin/groups/set_group_file_size_limit', :controller => 'admin/groups', :action => 'set_group_file_size_limit'

	map.connect '/admin/indices/set_index_title', :controller => 'admin/indices', :action => 'set_index_title'
	map.connect '/admin/indices/set_index_bind_domain', :controller => 'admin/indices', :action => 'set_index_bind_domain'
	map.connect '/admin/indices/set_index_info', :controller => 'admin/indices', :action => 'set_index_info'

	map.namespace :admin do |admin|
	    admin.resources :posts, :collection => {:destroy_selected => :post, :recategory_selected => :post}
	    admin.resources :drafts, :collection => {:destroy_selected => :post}
	    admin.resources :pages, :member => {:enable_fontpage => :post, :cancel_fontpage => :post}
	    admin.resources :users, :member => {:set_group => :post}
	    admin.resources :groups, :member => {:set_group_space => :post, :set_group_name => :post, :set_group_file_size_limit => :post}
	    admin.resources :indices, :member => {:add_manager => :post, :remove_manager => :post, :settings => :get, :change_settings => :post, :sidebar_position => :post}
	    admin.resources :comments, :collection => {:settings => :get, :set_filter_position => :post, :destroy_selected => :delete}
	    admin.resources :messages, :collection => {:destroy_selected => :delete}
	    admin.resources :trackbacks, :collection => {:destroy_selected => :delete}
	    admin.resources :talks
	    admin.resources :spams, :member => {:pass => :post}, :collection => {:destroy_selected => :delete}
	    admin.resources :categories, :has_many => [:posts, :drafts],
			    :collection => {:set_position => :post}
	    admin.resources :links, 
			    :collection => {:set_position => :post}
	    admin.resources :files, 
			    :collection => {:list => :get, :delete_file => :post, :delete_dir => :post}
	    admin.resources :feedbacks, :collection => {:destroy_selected => :delete} 
	    admin.resources :articles, :member => {:increase_rank => :post, :decrease_rank => :post}, :collection => {:destroy_selected => :delete} 
	end
	#map.admin_files "/admin/files/:action", :controller => "admin/files"

	map.connect "/add", :controller => 'blog', :action => "add"
	map.login   "/login", :controller => 'blog', :action => "login"
	map.forgot_password   "/forgot_password", :controller => 'blog', :action => "forgot_password"
	map.reset_password   "/reset_password/:key", :controller => 'blog', :action => "reset_password"#, :default => {:key => nil}
	map.connect "/guestbook", :controller => 'blog', :action => 'guestbook'


	map.connect "/articles/:id/:seo_title.:format", :controller => 'posts', :action => 'show'
	map.connect "/rss", :controller => 'posts', :action => 'index', :format => "rss"
	map.feed    "/feed", :controller => 'posts', :action => 'index', :format => "rss"
	map.connect "/show/:id.:format", :controller => 'posts', :action => 'show'
	map.site "/site.:format", :controller => 'blog', :action => 'index'
	
	map.connect "/setup", :controller => 'site', :action => "setup"
	#map.connect "/category/:category_id", :controller => 'posts', :action => 'list'
	#map.connect "/categpry/:category_id/page/:page", :controller => 'posts', :action => 'list'
	map.connect "/pages/:id/:seo_title.:format", :controller => 'pages', :action => 'show'
	#map.connect "/show_page/:id.:format", :controller => 'posts', :action => 'page'
	#map.connect "/page/:page", :controller => 'posts', :action => 'index'


	map.connect '/themes/:theme/*anything', :controller => 'theme', :action => 'user_theme_file'
	map.connect '/index/themes/:theme/*anything', :controller => 'theme', :action => 'index_theme_file'
	map.connect '/plugins/:plugin/*anything', :controller => 'plugin', :action => 'file'


	map.admin   '/admin', :controller => 'admin/dashboard', :action => "index"
	map.connect '/admin/logout', :controller => 'admin/dashboard', :action => "logout"

	map.connect '/admin/plugins/:plugin_id', :controller => 'admin/plugins', :action => 'index', :defaults => {:plugin_id => nil}
	map.connect '/admin/plugin_config/:plugin_id', :controller => 'admin/plugins', :action => 'plugin'
	map.connect '/admin/remote_form/:plugin/:view', :controller => 'admin/plugins', :action => 'remote_form'
	map.connect '/admin/remote_update', :controller => 'admin/plugins', :action => 'remote_update'
	map.connect '/admin/themes/:action/:id', :controller => 'admin/themes'
	map.connect '/admin/themesettings/:action/:id', :controller => 'admin/themesettings'

	map.connect '/admin/sidebar/:action/:id', :controller => 'admin/sidebar'
	#map.connect '/admin/index_sidebar/:action/:id', :controller => 'admin/index_sidebar'
	map.connect '/admin/navbar/:action/:id', :controller => 'admin/navbar'
	map.connect '/admin/postbar/:action/:id', :controller => 'admin/postbar'
	
	#map.connect '/admin/files/:action/:id', :controller => 'admin/files'
	map.connect '/admin/settings/:action/:id', :controller => 'admin/settings'
	map.connect '/admin/rss/:action/:id', :controller => 'admin/rss'
	map.connect '/admin/site/:action/:id', :controller => 'admin/site'

	map.connect '/admin/:action/:id',:controller => 'admin/dashboard'
	
	map.page_permalink '/:permalink', :controller => 'pages', :action => 'show'
	#map.connect "/:action/*anthing", :controller => 'posts'


	#map.connect "*anything", :controller => 'site', :action => 'unknown_request'
end

