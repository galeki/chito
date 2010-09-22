module Admin::DashboardHelper

    def show_dashboardbar(bar, options={})
        content_tag :li, :id => "bar_#{bar.id}" do
            bar_settings_area(bar).to_s +
            content_tag(:h2, title_of(bar)) +
            if options[:disable]
                content_tag :div, t(:save_to_see, :scope => [:txt, :view, :admin, :dashboard]), :class => "dashboardbar_content", :id => "bar_#{bar.id}_content"
            else
                content_tag :div, content_of(bar), :class => "dashboardbar_content", :id => "bar_#{bar.id}_content"
            end
        end
    end

end
