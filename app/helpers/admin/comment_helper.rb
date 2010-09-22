module Admin::CommentHelper

    def show_filter(filter)
         %Q[<li class="filter" id="bar_#{filter.id}">
                #{(link_to image_tag("setting.gif"), "#", 
                    {:onclick => "open_remote_form({'url':'#{filter.form_url}', 'title':'#{filter.name}', 'width':450});", 
                    :class => "remote_setting"} )  if filter.config} 
                #{filter.name } 
            </li>].html_safe
    end

end
