module Admin::CommentHelper

    def show_filter(filter)
	 %Q[<li class="filter" id="filter_#{filter.id}">
		#{(link_to_ajax_dialog 'confirm', image_tag("setting.gif"),
				      {:url => filter.form_url, :title => filter.name, :width => 300,  :okLabel => "Save",:cancelLabel => "Cancel", :className => "alphacube", 
				       :draggable => true, :resizable => true, :closable => true, :destroyOnClose => true,
				       :onOk => "function(win){ remote_form();return true;}"}, 
				      {:class => "remote_setting"}) if filter.config} 
		#{filter.name } 
	    </li>]
    end

end
