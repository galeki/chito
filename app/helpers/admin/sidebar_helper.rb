module Admin::SidebarHelper

    def show_bar(bar)
	 %Q[<li class="bar" id="bar_#{bar.id}">
		#{text_field :user, bar.title_name,  :value => bar.title}
		<div class="bar_info">
		#{bar_settings_area(bar)} 
		#{bar.info} 
		</div>
	    </li>]
    end

    def bar_settings_area(bar)
	if(bar.jump)
	    link_to image_tag("setting.gif"), bar.jump, :target => "_blank", :class => "remote_setting"
	else
	    (link_to image_tag("setting.gif"), "#", 
		    {:onclick => "open_remote_form({'url':'#{bar.form_url}', 'title':'#{bar.info}', 'width':450});", 
		    :class => "remote_setting"} )  if bar.config
	end
    end

    def bars_layout
	template = "#{@user.theme}/views/bars_config"
	render :partial => template
	rescue
	render :partial => 'bars_config'
    end

    def theme_settings
	template = "#{@user.theme}/views/admin/theme_settings"
	render :partial => template
	rescue
	render :partial => 'theme_settings'
    end

    def sidebars_in(field)
	@all_bars.select{|b| b.field.to_sym == field && b.show?}.sort_by{|b| b.position}
    end

    def vbars(options={})
	bar_html(:vertical, "vbars", options)
    end

    def hbars(options={})
	bar_html(:horizontal, "hbars", options)
    end  

    def bar_html(overlap, klass, options={})
	@overlap[options[:field]] = overlap
	html = "<ul id='#{options[:field]}' class='#{klass}' style='#{options[:style]}'>"
	html << "<div class='bars_title'>#{options[:title]}</div>"
	for bar in sidebars_in(options[:field])
	    html << show_bar(bar)
	end
	html << '</ul>'
    end	

end
