    module BlogHelperPlugin
	def add_patch_before_rss_content
	    @user.patch_before_rss_content.to_s
	end
	def add_patch_after_rss_content
	    @user.patch_after_rss_content.to_s
	end
    end
