module ThemeHelper

    def theme_css_links(options={})
	if options[:order]
	    options[:order].inject(""){|html,css| html << stylesheet_link_tag("/themes/#{@theme}/stylesheets/#{css}") << "\n"}
	else
	    @css_list = theme_files(@theme, :stylesheets)
	    @css_list.inject(""){|html,css| html <<  stylesheet_link_tag(css) << "\n"}
	end
    end

    def theme_js_links(options={})
	if options[:order]
	    options[:order].inject(""){|html,js| html << javascript_include_tag("/themes/#{@theme}/javascripts/#{js}") << "\n"}
	else
	    @js_list = theme_files(@theme, :javascripts)
	    @js_list.inject(""){|html,js| html << javascript_include_tag(js) << "\n"}
	end
    end

    private
    
    def theme_files(theme, type)
	case type
	when :javascripts
	    ext = "js"
	when :stylesheets
	    ext = "css"
	else
	    ext = "*"
	end
	Dir["#{RAILS_ROOT}/themes/#{theme}/#{type}/*.#{ext}"].map do |file| 
	    "/themes/#{theme}/#{type}/#{File.basename(file)}"
	end
    end

end
