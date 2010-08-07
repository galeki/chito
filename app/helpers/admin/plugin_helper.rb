module Admin::PluginHelper

    def options_div(title, &block)
        content = with_output_buffer(&block)
        content_tag(:div, :class => "edit_field") do
            content_tag(:div, "", :class => "right_c") +
            content_tag(:div, title, :class => "edit_header") +
            content
        end
    end

end
