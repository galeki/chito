    module BlogHelperPlugin
        def rewriter_of_post_time
            "<span class='relative_time_post'>#{@post.created_at.strftime("%b %d, %Y %I:%M:%S %p")}</span>".html_safe
        end
        def rewriter_of_comment_time
            "<span class='relative_time_comment'>#{@comment.created_at.strftime("%b %d, %Y %I:%M:%S %p")}</span>".html_safe
        end
        def add_relative_time_convert_in_blog_tail
            func = ""
            locale = I18n.locale
            func << "_show_relative_time('span.relative_time_post', '#{locale}');" if @user.enable_rewriter_of_post_time
            func << "_show_relative_time('span.relative_time_comment', '#{locale}');" if @user.enable_rewriter_of_comment_time
            unless func.blank?
            %Q! <script type="text/javascript">
                    function show_relative_time(){
                        #{func}
                    }
                    $(document).ready(show_relative_time);
                </script>
              !.html_safe
            end
        end
    end
