module ApplicationPlugin
    private

    def force_comment_avatar_after_get_user
	if @user
	    @user.enable_comment_filter_simple_vcode = true
	end
    end

end

