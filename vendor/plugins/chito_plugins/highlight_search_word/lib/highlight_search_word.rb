    module BlogHelperPlugin

    	def highlight_search_word_in_blog_tail
	    if !params[:s].blank? && @user.enable_highlight_search_word 
		%Q~ <script type="text/javascript"> 
		    function hlw(){
			highlightWord(document.getElementsByTagName("body")[0],"#{params[:s]}");
		    }
                    $(document).ready(hlw);
		    </script>~ 
	    end
	end


	def add_highlight_search_word_js_in_head
	    if @user.enable_highlight_search_word
		plugin_javascript_inculde_tag('highlight_search_word', "searchhi")
	    end
	end
    end

    module BlogControllerPlugin
	private
	def add_highlight_search_word_css_in_plugin_css
	    if @user.enable_highlight_search_word
		@plugin_css << %Q~.searchword { background-color: yellow;}~
	    end
	end
    end
