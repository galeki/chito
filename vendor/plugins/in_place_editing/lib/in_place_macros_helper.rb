module InPlaceMacrosHelper

  def in_place_edit(object, method, id, content, options={})
    tag = %Q[<span id='#{id}_#{method}' class='in_place_edit_#{object}_#{method}' onmouseover="this.style.backgroundColor='yellow'" onmouseout="this.style.backgroundColor='white'" >]
    tag << content
    tag << "</span>"
  end

  def in_place_edit_js(object, method, options={})
    js = javascript_tag %Q!
	  $(document).ready(function() {
	    $(".in_place_edit_#{object}_#{method}").editable("#{url_for :controller => object.to_s.pluralize, :action => "set_#{object}_#{method}"}", {
		indicator : '#{t(:saving, :scope => [:txt])}',
		submitdata: { _method: "get", authenticity_token: "#{form_authenticity_token}" },
		select : true,
		submit : '#{t(:save, :scope => [:txt])}',
		cancel : '#{t(:cancel, :scope => [:txt])}',
		tooltip   : '#{t(:click_to_edit_text, :scope => [:txt])}',
		});
	    });
    !
  end
end
