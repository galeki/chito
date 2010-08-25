class Xmlrpc::MetaWeblogController < Xmlrpc::BaseController
    before_filter :get_user, :get_locale
    method_alias "getPageList"=> "getPages", "getCategoryList" => "getCategories"

    def getUsersBlogs
    end

    def getUserInfo
    end

    def getPages
        num = @method_params[3].to_num(5)
        @pages = @user.pages.order("created_at desc").limit(num).includes(:category)
    end

    def getRecentPosts
        num = @method_params[3].to_num(10)
        @recent_posts = @user.posts.order("created_at desc").limit(num).includes(:category)
    end

    def getPost
        id = @method_params[0]
        @post = @user.articles.find(id)
    end

    def getCategories
        @categories = @user.categories
    end

    def getPostCategories
        id = @method_params[0]
        @post = @user.articles.find(id)
        @category = @post.category
    end

    def setPostCategories
        id = @method_params[0]
        unless @method_params[3].first.blank?
            category_id = @method_params[3].first["categoryId"]
            @category = @user.categories.find(category_id.to_i)
        else
            @category = @user.categories.first
        end
        @post = @user.articles.find(id)
        @post.category_id = @category.id if @category
        @post.save
    end

    def newPost
        @post = Article.new
        fill_article(@post)
        raise_fault(4, "Post was not saved") unless @post.save
    end

    def editPost
        id = @method_params[0]
        @post = @user.articles.find(id)
        fill_article(@post)
        raise_fault(4, "Post was not updated") unless @post.save
    end

    def deletePost
        id = @method_params[1]
        post = @user.articles.find(id)
        raise_fault(4, "Post was not deleted") unless post.destroy
    end

    def newPage
        @page = Article.new
        @page.is_page = true
        @page.show_as_navbar = true
        fill_article(@page)
        raise_fault(4, "Page was not saved") unless @page.save
    end

    def newCategory
        name = @method_params[3]['name']
        @category = @user.categories.new({:name => name})
        raise_fault(4, "Category was not created") unless @category.save
    end

    def publishPost
    end

    def newMediaObject
        name = @method_params[3]['name']
        type = @method_params[3]['type']
        bits = @method_params[3]['bits']

        group = @user.get_group
        file_size_limit = group.file_size_limit
        space_limit = group.space

        if type =~ /image/ || name =~ /(\.jpg|\.jpeg|\.png|\.gif|\.svg)$/ 
            dir = "Image" 
        else
            dir = "File"
        end

        file_data = StringIO.new(bits)
        if file_data.nil?
            @error_message = t(:no_file, :scope => [:txt, :controller, :admin, :files])
        elsif file_data.length > file_size_limit.megabytes
            @error_message = t(:file_too_large, :scope => [:txt, :controller, :admin, :files], :size => file_size_limit)
        elsif  (@user.used_space.kilobytes + file_data.length) > (space_limit.megabytes)
            @error_message = t(:no_space, :scope => [:txt, :controller, :admin, :files])
        else
            new_file_path = File.join(@user.base_dir, dir, name)
            file_name = name
            if File.exist?(new_file_path)
                file_name = File.basename(file_name, ".*") + "_" + Time.now.strftime("%Y%m%d%H%M%S") + File.extname(file_name)
                new_file_path =  File.join(@user.base_dir, dir, file_name)
            end
            raise_fault(4, nil) unless File.expand_path(new_file_path).start_with?(@user.base_dir)
            dir_path = File.dirname(new_file_path)
            FileUtils.makedirs(dir_path) unless File.exists?(dir_path)
            File.open(new_file_path,"wb",0664) do |fp|
                FileUtils.copy_stream(file_data, fp)
            end
            @new_file_url = new_file_path.sub(/^#{Rails.root}\/public/,'')
            @new_file_url = @new_file_url.to_s.force_encoding('UTF-8') if RUBY_VERSION > "1.9"
            @user.dirty_space
        end
        raise_fault(2041, @error_message) if @error_message
    end

    private
    def get_user
        if %W(deletePost).include?(@method_name)
            username = @method_params[2]; password = @method_params[3]
        else
            username = @method_params[1]; password = @method_params[2]
        end
        @user = User.login(username, password) 
        return if @user
        raise_fault(2041, "Error username or passowrd")
    end

    def fill_article(article)
        data = @method_params[3]
        is_publish = @method_params[4]
        custom_fields = data['custom_fields']
        p = {:article => {:title => data['title'], :content => data['description']}}
        unless data['categories'].blank?
            category = @user.categories.find_by_name(data['categories'].first)
            p[:category] = category.id if category
        end
        if custom_fields
            custom_fields.each do |c|
                next if c["key"].blank?
                p[:article][c["key"].to_sym] = c["value"]
            end
        end
        index = Index.first
        article.index_id = index.id if index
        article.prepare(@user, p)
        article.auto_brief = true
        article.is_draft = !is_publish
        article.make_brief
    end

end
