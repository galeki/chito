module ActionView
  module Helpers 
    module UrlHelper
	private
        def convert_options_to_javascript!(html_options, url = '')
          confirm, popup = html_options.delete("confirm"), html_options.delete("popup")

          method, href = html_options.delete("method"), html_options['href']

          html_options["onclick"] = case
            when popup && method
              raise ActionView::ActionViewError, "You can't use :popup and :method in the same link"
            when confirm && popup
              "if (#{confirm_javascript_function(confirm)}) { #{popup_javascript_function(popup)} };event.returnValue=false;return false;"
            when confirm && method
              "if (#{confirm_javascript_function(confirm)}) { #{method_javascript_function(method)} };event.returnValue=false;return false;"
            when confirm
              "return #{confirm_javascript_function(confirm)};"
            when method
              "#{method_javascript_function(method, url, href)}event.returnValue=false;return false;"
            when popup
              popup_javascript_function(popup) + 'event.returnValue=false;return false;'
            else
              html_options["onclick"]
          end
        end	
    end
  end
end


