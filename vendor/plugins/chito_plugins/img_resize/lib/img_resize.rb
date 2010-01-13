    module BlogHelperPlugin
	def resize_img_in_blog_tail
	    %Q~ <script type="text/javascript">
		function auto_resize_img(){
		    ReImgSize(#{@user.img_max_width || 400}, "#{t("plugins.img_resize.new_window")}");
		}
		$(document).ready(auto_resize_img);
		</script>~ 
	end
    end
