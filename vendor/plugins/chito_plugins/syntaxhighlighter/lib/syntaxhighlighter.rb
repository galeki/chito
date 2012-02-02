    module BlogHelperPlugin
        def add_syntaxhighlighter_css_link_in_head
            head = ""
            if @user.enable_syntaxhighlighter
                theme = @user.syntaxhighlighter_theme || "Default"
                head += plugin_stylesheet_link_tag('syntaxhighlighter', "shCore.css") + "\n"
                head += plugin_stylesheet_link_tag('syntaxhighlighter', "shTheme#{theme}.css") + "\n"
            end
            return head.html_safe
        end

        def add_syntaxhighlighter_js_link_in_blog_tail
            head = ""
            if @user.enable_syntaxhighlighter
                head = plugin_javascript_inculde_tag('syntaxhighlighter', "shCore.js") + "\n"
                
                head += plugin_javascript_inculde_tag('syntaxhighlighter', "shBrushes.js") + "\n"

                head += %Q!<script type="text/javascript">SyntaxHighlighter.all();</script>!.html_safe

            end
            return head.html_safe
        end
    end
