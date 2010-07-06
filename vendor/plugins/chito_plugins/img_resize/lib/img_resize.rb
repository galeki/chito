    module BlogHelperPlugin
	def resize_img_in_blog_tail
            if @user.img_resize_style == 'lightbox'
                html = plugin_javascript_inculde_tag('img_resize', "jquery.lightbox-0.5.pack.js") + "\n"
                html += plugin_javascript_inculde_tag('img_resize', "core.js") + "\n"
                html += plugin_stylesheet_link_tag('img_resize', "jquery.lightbox-0.5.css") + "\n"
                html +=  %Q~ <script type="text/javascript">
		    function auto_resize_img(){
		        img_resize_lightbox(#{@user.img_max_width || 400});
		    }
		    $(document).ready(auto_resize_img);
		    </script>~.html_safe
            else
                html = plugin_javascript_inculde_tag('img_resize', "core.js") + "\n"
	        html += %Q~ <script type="text/javascript">
		    function auto_resize_img(){
		        img_resize_normal(#{@user.img_max_width || 400}, "#{t("plugins.img_resize.new_window")}");
		    }
		    $(document).ready(auto_resize_img);
		    </script>~.html_safe
            end
            html
	end
    end
