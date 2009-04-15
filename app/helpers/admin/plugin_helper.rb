module Admin::PluginHelper

    def options_div(title, &proc)
	concat %Q[<div class="edit_field">\n<div class="right_c"></div>\n<div class="edit_header">#{title}</div>\n]
	yield
	concat "</div>\n"
    end

end
