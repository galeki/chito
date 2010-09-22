module Admin::NavbarHelper

    def show_navbar(bar)
         %Q[<li class="navbar" id="bar_#{bar.id}">
                <div class="nav_info">
                #{(link_to image_tag("setting.gif"), "#", 
                    {:onclick => "open_remote_form({'url':'#{bar.form_url}', 'title':'#{bar.info}', 'width':450});", 
                    :class => "remote_setting"} )  if bar.config} 
                #{h(bar.i18n_title)} 
                </div>
            </li>].html_safe
    end


end
