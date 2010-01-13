    module BlogHelperPlugin
	def add_patch_before_post_content
	    @user.patch_before_post_content.to_s
	end
	def add_patch_after_post_content
	    @user.patch_after_post_content.to_s
	end
	def add_patch_after_post_brief
	    @user.patch_after_post_brief.to_s
	end
    end
