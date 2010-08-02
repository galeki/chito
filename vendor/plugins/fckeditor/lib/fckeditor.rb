# Fckeditor
module Fckeditor
  PLUGIN_NAME = 'fckeditor'
  PLUGIN_PATH = "#{Rails.root}/vendor/plugins/#{PLUGIN_NAME}"
  PLUGIN_PUBLIC_PATH = "#{PLUGIN_PATH}/public"
  PLUGIN_CONTROLLER_PATH = "#{PLUGIN_PATH}/app/controllers"  
  PLUGIN_VIEWS_PATH = "#{PLUGIN_PATH}/app/views"  
      
  module Helper
    def fckeditor_textarea(object, field, options = {})
      value = eval("@#{object}.#{field}")
      value = value.nil? ? "" : value
      id = fckeditor_element_id(object, field)
      
      cols = options[:cols].nil? ? '' : "cols='"+options[:cols]+"'"
      rows = options[:rows].nil? ? '' : "rows='"+options[:rows]+"'"
      
      width = options[:width].nil? ? '100%' : options[:width]
      height = options[:height].nil? ? '100%' : options[:height]
      
      toolbarSet = options[:toolbarSet].nil? ? 'Default' : options[:toolbarSet]
      
      if options[:ajax]
        inputs = "<input type='hidden' id='#{id}_hidden' name='#{object}[#{field}]'>\n"+    
                 "<textarea id='#{id}' #{cols} #{rows} name='#{id}'>#{value}</textarea>\n"
      else 
        inputs = "<textarea id='#{id}' #{cols} #{rows} name='#{object}[#{field}]'>#{value}</textarea>\n"
      end

      base_path = @request.relative_url_root.to_s+'/javascripts/fckeditor/'
      inputs + 
      javascript_tag( "var oFCKeditor = new FCKeditor('#{id}', '#{width}', '#{height}', '#{toolbarSet}');\n"+
                      "oFCKeditor.BasePath = \"#{base_path}\"\n"+
                      "oFCKeditor.Config['CustomConfigurationsPath'] = '../../fckcustom.js';\n"+
                      "oFCKeditor.ReplaceTextarea();\n")                         
    end
    
    def fckeditor_form_remote_tag(options = {})
      editors = options[:editors]
      before = ""
      editors.keys.each do |e|
        editors[e].each do |f|
          before += fckeditor_before_js(e, f)
        end
      end
      options[:before] = options[:before].nil? ? before : before + options[:before] 
      form_remote_tag(options)
    end
    
    def fckeditor_remote_form_for(object_name, *args, &proc)
      options = args.last.is_a?(Hash) ? args.pop : {}
      concat(fckeditor_form_remote_tag(options), proc.binding)
      fields_for(object_name, *(args << options), &proc)
      concat('</form>', proc.binding)
    end
    alias_method :fckeditor_form_remote_for, :fckeditor_remote_form_for
    
    def fckeditor_element_id(object, field)
      id = eval("@#{object}.id")
      "#{object}__#{field}_editor"    
    end

    def fckeditor_div_id(object, field)
      id = eval("@#{object}.id")  
      "div-#{object}-#{id}-#{field}-editor" 
    end

    def fckeditor_before_js(object, field)
      id = fckeditor_element_id(object, field)
      "var oEditor = FCKeditorAPI.GetInstance('"+id+"'); $('"+id+"_hidden').value = oEditor.GetXHTML();"
    end    
  end
end

#include ActionView
#module ActionView::Helpers::AssetTagHelper
  #alias_method :rails_javascript_include_tag, :javascript_include_tag
  
  #  <%= javascript_include_tag :defaults, :fckeditor %>
  #def javascript_include_tag(*sources)
  #  main_sources, application_source = [], []
  #  if sources.include?(:fckeditor)
  #    sources.delete(:fckeditor)
  #    sources.push('fckeditor/fckeditor')
  #  end
  #  unless sources.empty?
  #    main_sources = rails_javascript_include_tag(*sources).split("\n") 
  #    application_source = main_sources.pop if main_sources.last.include?('application.js')
  #  end
  #  [main_sources.join("\n"), application_source].join("\n")
  #end
#end
