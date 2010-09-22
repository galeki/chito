module Admin::ArticleHelperPlugin
    def show_post_icon_filed_in_article_form
        if @user.is_chito_admin?
            plugin_render :post_icon, :post_icon_field
        end
    end
end
module Admin::ArticleControllerPlugin
    private
    def save_post_icon_before_article_save
        if @user.is_chito_admin?
            file = params[:post_icon]
            if file.respond_to?('content_type') && file.content_type =~ /^image/
                @article.save
                save_post_icon_to_disk(@article.id, file)
            end
        end
    end

    def save_post_icon_to_disk(id, file)
        Dir.mkdir("#{@user.base_dir}/Image/post_icons") unless File.exists?("#{@user.base_dir}/Image/post_icons")
        File.open("#{@user.base_dir}/Image/post_icons/post_#{id}.png", "wb") do |f| 
            f.write(file.read)
        end     
    end
end
module BlogHelperPlugin
    def show_post_icon_before_post_brief
        if @user.is_chito_admin?
            if File.exists?("#{@user.base_dir}/Image/post_icons/post_#{@post.id}.png")
                content_tag :div, :class => "post_icon" do
                    image_tag "/user_files/#{@user.name}/Image/post_icons/post_#{@post.id}.png"
                end
            end
        end
    end
end
module BlogControllerPlugin
        private
        def add_post_icon_div_css_in_plugin_css
            @plugin_css << "div.post_icon{padding:5px;float:left;}" if @user.is_chito_admin?
        end
end
