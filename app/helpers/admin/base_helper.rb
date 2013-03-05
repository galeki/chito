module Admin::BaseHelper

    def select_admin_menu(main_menu, options={})
        sub_menu = options[:sub_menu] || "_#{controller.controller_name}_#{controller.action_name}"
        javascript_tag "select_menu('#{main_menu}', '#{sub_menu}');"
    end

    def remote_form(&block)
        content_tag(:div, :class => "rmf", :style => "text-align:left;padding:10px 10px 0 10px;") do
            form_for(:user, :html => {:id => 'remote_form', :onsubmit => "return false;"}, &block)
        end
    end

    def remote_form_index(&block)
        content_tag(:div, :class => "rmf", :style => "text-align:left;padding:10px 10px 0 10px;") do
            form_for(:index, :html => {:id => 'remote_form', :onsubmit => "return false;"}, &block)
        end
    end

    def selected_button(options={})
        content_tag :input, nil, :class => options[:class] || "selected_submit",
                    :type => "button", :value => options[:text],
                    :onclick => %Q[if(confirm("#{options[:confirm]}")){
                                    this.form.action = "#{options[:url]}";
                                    this.form.submit();}]
    end

    def expire_cache_field(options={})
        hidden_field_tag "expire_requests[]", chito_cache_key(options)
    end

    def sidebar_expire_cache_field(id, options={})
        hidden_field_tag "expire_requests[]", chito_cache_key(options.merge(:part => :plugins, :type => :sidebars, :id => id))
    end

    def has_notifier
        @notifier_path = admin_spams_path if @user.has_new_spam
        @notifier_path = admin_talks_path if @user.has_new_talk
        @notifier_path
    end
end
