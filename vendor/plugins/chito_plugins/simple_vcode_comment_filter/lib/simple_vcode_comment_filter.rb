filter = CommentFilter.new(:simple_vcode, 'Simple Captcha', 'check_simple_vcode')
CommentFilter.add(filter)

module BlogHelperPlugin
    def show_simple_vcode_field_in_comment_form
        if @user.enable_comment_filter_simple_vcode && session[:user_name].nil?
            "<div id='show_simple_captcha'>" +
                show_simple_captcha(:image_style => "simply_green", :label => t("txt.view.blog.add.input_captcha"), :distortion => "high") +
            "</div>"
        end
    end
end

module BlogControllerPlugin
end

module CommentControllerPlugin
  private

  def check_simple_vcode
    if session[:user_name].nil?
        @call = "re_captcha"
        unless simple_captcha_valid?
            block_filter(:type => :error, :message => t("plugins.simple_vcode_comment_filter.error_captcha"), :drop => true)
        end
    end
  end

end
