module Admin::NavbarHelper

    def show_navbar(bar)
	 %Q[<li class="navbar" id="bar_#{bar.id}">
		<div class="nav_info">
		#{(link_to_ajax_dialog 'confirm', image_tag("setting.gif"),
				      {:url => bar.form_url, :title => bar.i18n_title, :width => 300,  :okLabel => t("txt.save"),:cancelLabel => t("txt.cancel"), :className => "alphacube", 
				       :draggable => true, :resizable => true, :closable => true, :destroyOnClose => true,
				       :onOk => "function(win){ remote_form();return true;}"}, 
				      {:class => "remote_setting"}) if bar.config} 
		#{bar.i18n_title} 
		</div>
	    </li>]
    end


end
