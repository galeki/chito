    module BlogHelperPlugin
	def add_syntaxhighlighter_css_js_link_in_head
	    if @user.enable_syntaxhighlighter
		head = plugin_javascript_inculde_tag('syntaxhighlighter', "shCore.js") + "\n"
		
		%w(shBrushAS3.js
		    shBrushBash.js
		    shBrushCpp.js
		    shBrushCSharp.js
		    shBrushCss.js
		    shBrushDelphi.js
		    shBrushDiff.js
		    shBrushGroovy.js
		    shBrushJavaFX.js
		    shBrushJava.js
		    shBrushJScript.js
		    shBrushLua.js
		    shBrushPerl.js
		    shBrushPhp.js
		    shBrushPlain.js
		    shBrushPowerShell.js
		    shBrushPython.js
		    shBrushRuby.js
		    shBrushScala.js
		    shBrushSql.js
		    shBrushVb.js
		    shBrushXml.js
		).each do |js|
		    head += plugin_javascript_inculde_tag('syntaxhighlighter', js) + "\n"
		end
		head += %Q!<script type="text/javascript">SyntaxHighlighter.config.clipboardSwf = '/plugins/syntaxhighlighter/javascripts/clipboard.swf';SyntaxHighlighter.all();</script>!

		head += plugin_stylesheet_link_tag('syntaxhighlighter', "shCore.css") + "\n"

		theme = @user.syntaxhighlighter_theme || "Default"
		head += plugin_stylesheet_link_tag('syntaxhighlighter', "shTheme#{theme}.css") + "\n"
	    end
	    return head
	end
    end
