Chito::Application.routes.draw do
  constraints(IndexMatch) do
    match '/' => 'index#index'
    match '/index.rss' => 'index#index', :as => :index_feed, :format => 'rss'
    match '/index_plugin.css' => 'index#plugin_css', :as => :index_plugin_css
  end
  root :to => 'posts#index'
  match '/favicon.ico' => 'blog#favicon', :as => :favicon
  match '/plugin.css' => 'blog#plugin_css', :as => :plugin_css
  match '/simple_captcha(/:action)' => 'simple_captcha', :as => :simple_captcha
  match '/simple_captcha_ajax' => 'simple_captcha#simple_captcha_ajax'
  match '/:year/:month/:day/:permalink.:id.:format' => 'posts#show', :constraints => { :year => /(19|20)\d\d/, :month => /[0|1]?\d/, :day => /[0-3]?\d/ }
  match ':year/:month' => 'posts#index', :as => :archive, :constraints => { :year => /\d{4}/, :month => /\d{1,2}/ }

  resources :posts do
    member do
        get :cancel_comment_notifier
    end 
  end

  resources :categories do
    resources :posts
  end
  resources :posts do
    resources :comments
  end

  resources :pages
  resources :messages
  match '/comments.:format' => 'comments#index', :as => :comments
  match '/tag/*tag_name' => 'posts#index', :as => :tag_posts
  match '/admin/links/set_link_title' => 'admin/links#set_link_title'
  match '/admin/links/set_link_url' => 'admin/links#set_link_url'
  match '/admin/links/set_link_info' => 'admin/links#set_link_info'
  match '/admin/categories/set_category_name' => 'admin/categories#set_category_name'
  match '/admin/categories/set_category_info' => 'admin/categories#set_category_info'
  match '/admin/users/set_user_bind_domain' => 'admin/users#set_user_bind_domain'
  match '/admin/groups/set_group_space' => 'admin/groups#set_group_space'
  match '/admin/groups/set_group_file_size_limit' => 'admin/groups#set_group_file_size_limit'
  match '/admin/indices/set_index_title' => 'admin/indices#set_index_title'
  match '/admin/indices/set_index_bind_domain' => 'admin/indices#set_index_bind_domain'
  match '/admin/indices/set_index_info' => 'admin/indices#set_index_info'

  namespace :admin do
    resources :posts do
        collection do
            post :destroy_selected
            post :recategory_selected
        end
    end

    resources :drafts do
        collection do
            post :destroy_selected
        end
    end

    resources :pages do
        member do
            post :enable_fontpage
            post :cancel_fontpage
        end
    end
      
    resources :users do 
        member do
            post :set_group
        end
    end
    
    resources :groups do
        member do
            post :set_group_space
            post :set_group_name
            post :set_group_file_size_limit
        end
    end

    resources :indices do
        member do
            post :add_manager
            post :remove_manager
            get :settings
            post :change_settings
            post :sidebar_position
            post :save_avatar
        end
    end

    resources :comments do
        collection do
            get :settings
            post :set_filter_position
            delete :destroy_selected
        end
    end

    resources :messages do
        collection do
            delete :destroy_selected
        end
    end

    resources :trackbacks do
        collection do
            delete :destroy_selected
        end
    end

    resources :talks

    resources :spams do
        collection do
            delete :destroy_selected
        end
        member do
            post :pass
        end
    end

    resources :categories do
        resources :posts
        collection do
            post :set_position
        end
    end
      
    resources :links do
        collection do
            post :set_position
        end
    end

    resources :files do
        collection do
            get :list
            post :delete_file
            post :delete_dir
        end
    end
      
    resources :feedbacks do
        collection do
            delete :destroy_selected
        end
    end
    
    resources :articles do
        collection do
            delete :destroy_selected
        end
        member do
            post :increase_rank
            post :decrease_rank
        end
    end

  end

  match '/add' => 'blog#add'
  match '/login' => 'blog#login', :as => :login
  match '/forgot_password' => 'blog#forgot_password', :as => :forgot_password
  match '/reset_password/:key' => 'blog#reset_password', :as => :reset_password
  match '/guestbook' => 'blog#guestbook', :as => :guestbook
  match '/articles/:id/:seo_title.:format' => 'posts#show'
  match '/rss' => 'posts#index', :format => 'rss'
  match '/feed' => 'posts#index', :as => :feed, :format => 'rss'
  match '/show/:id.:format' => 'posts#show'
  match '/site.:format' => 'blog#index', :as => :site
  match '/setup' => 'site#setup'
  match '/pages/:id/:seo_title.:format' => 'pages#show'
  match '/themes/:theme/*anything' => 'theme#user_theme_file'
  match '/index/themes/:theme/*anything' => 'theme#index_theme_file'
  match '/plugins/:plugin/*anything' => 'plugin#file'
  match '/admin' => 'admin/dashboard#index', :as => :admin
  match '/admin/logout' => 'admin/dashboard#logout'
  match '/admin/plugins/(:plugin_id)' => 'admin/plugins#index'
  match '/admin/plugin_config/:plugin_id' => 'admin/plugins#plugin'
  match '/admin/remote_form/:plugin/:view' => 'admin/plugins#remote_form'
  match '/admin/remote_update' => 'admin/plugins#remote_update'
  match '/admin/themes/:action/(:id)' => 'admin/themes#index'
  match '/admin/themesettings/:action/(:id)' => 'admin/themesettings#index'
  match '/admin/sidebar/:action/(:id)' => 'admin/sidebar#index'
  match '/admin/navbar/:action/(:id)' => 'admin/navbar#index'
  match '/admin/postbar/:action/(:id)' => 'admin/postbar#index'
  match '/admin/settings/:action/(:id)' => 'admin/settings#index'
  match '/admin/rss/:action/(:id)' => 'admin/rss#index'
  match '/admin/site/:action/(:id)' => 'admin/site#index'
  match '/admin/systeminfo/:action/(:id)' => 'admin/systeminfo#index'
  match '/admin/:action/:id' => 'admin/dashboard#index'
  match '/:permalink' => 'pages#show', :as => :page_permalink
end
