    module BlogHelperPlugin
        def resize_img_in_blog_tail
            width = @user.img_max_width || 400
            if @user.img_resize_style == 'lightbox'
                html = ""
                html += plugin_javascript_inculde_tag('img_resize', "jquery.ui.rlightbox.min.js") + "\n"
                html += plugin_javascript_inculde_tag('img_resize', "core.js") + "\n"
                html += plugin_stylesheet_link_tag('img_resize', "lightbox.min.css") + "\n"
                html +=  %Q~ <script type="text/javascript">
                    function auto_resize_img(){
                        img_resize_lightbox(#{width});
                    }
                    $(document).ready(auto_resize_img);
                    </script>~.html_safe
            else
                html = plugin_javascript_inculde_tag('img_resize', "core.js") + "\n"
                html += %Q~ <script type="text/javascript">
                    function auto_resize_img(){
                        img_resize_normal(#{width}, "#{t("plugins.img_resize.new_window")}");
                    }
                    $(document).ready(auto_resize_img);
                    </script>~.html_safe
            end
            html
        end
    end
