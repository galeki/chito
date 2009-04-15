module PluginHelper

    def plugin_render(plugin, view, options={})
	path = "#{plugin}/app/views/#{view}"
	render :partial => path
    end

    def plugin_image_tag(plugin, img)
	image_tag "/plugins/#{plugin}/images/#{img}"
    end

    def plugin_stylesheet_link_tag(plugin, css)
	stylesheet_link_tag "/plugins/#{plugin}/stylesheets/#{css}"
    end

    def plugin_javascript_inculde_tag(plugin, js)
	javascript_include_tag "/plugins/#{plugin}/javascripts/#{js}"
    end

end
