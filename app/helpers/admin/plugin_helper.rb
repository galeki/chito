module Admin::PluginHelper

    def options_div(title, &proc)
	concat %Q[<div class="edit_field">\n<div class="right_c"></div>\n<div class="edit_header">#{title}</div>\n].html_safe
	yield
	concat "</div>\n".html_safe
    end

end
