module BlogControllerPlugin
        private
        def add_custom_css_in_plugin_css
            @plugin_css << (@user.custom_css.blank? ? '' : @user.custom_css)
        end
end
