# Prototype Window Class Helper (http://pwc-helper.xurdeonrails.com)
# by Jorge D?az (http://xurde.info)
# thanks to Sebastien Gruhier for his Prototype Window Class (http://prototype-window.xilinus.com/)

#Quick use:
#Reference this helper in your rails applicaction adding -> helper :prototype_window_class in your application.rb
#You must include in the template header the prototype window class javascripts and the .css theme you want to use.
#This code in your template might be enough:

    #  <%= stylesheet_link_tag 'default' %> (or theme you wanna use)
    #  <%= stylesheet_link_tag 'alert' %>
    #  <%= javascript_include_tag :defaults %>
    #  <%= javascript_include_tag 'window'%>


module PrototypeWindowClassHelper

    def params_for_javascript(params) #options_for_javascript doesn't works fine
        '{' + params.map {|k, v| "#{k}: #{ 
            case v
              when Hash then params_for_javascript( v )
              when /\(.*\)/ then "#{v}"          
              when String then "'#{v}'"          
            else v   #Isn't neither Hash or String
            end }"}.sort.join(', ') + '}'
    end
    
    
    def link_to_ajax_dialog( type, name, options = { } , html_options = {} )
        js_code =%Q!Dialog.#{type}( {url: '#{options.delete(:url)}', options: {method: 'get'}},  #{params_for_javascript(options) } ); !
	link_to name, html_options[:href] || "#", :onclick => js_code, :class => html_options[:class]
    end

end
