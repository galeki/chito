    module BlogHelperPlugin
	def add_syntaxhighlighter_css_js_link_in_blog_tail
            head = ""
	    if @user.enable_syntaxhighlighter
		head = plugin_javascript_inculde_tag('syntaxhighlighter', "shCore.js") + "\n"
		
		head += plugin_javascript_inculde_tag('syntaxhighlighter', "shBrushes.js") + "\n"

		head += %Q!<script type="text/javascript">SyntaxHighlighter.config.clipboardSwf = '/plugins/syntaxhighlighter/javascripts/clipboard.swf';SyntaxHighlighter.all();</script>!.html_safe

		head += plugin_stylesheet_link_tag('syntaxhighlighter', "shCore.css") + "\n"

		theme = @user.syntaxhighlighter_theme || "Default"
		head += plugin_stylesheet_link_tag('syntaxhighlighter', "shTheme#{theme}.css") + "\n"
	    end
	    return head.html_safe
	end
    end
