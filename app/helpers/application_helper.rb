module ApplicationHelper
    include ActsAsTaggableOn::TagsHelper
    include ApplicationHelperPlugin
    include Chito::CacheHelper

    def c(key)
        cookies[key].to_s.force_encoding('UTF-8')
    end

    def render_flash(options={})
        render_stickies({:close => t("txt.close") }.update(options)).html_safe
    end

    def jquery_include_tag
        if @site.use_external_jquery
           javascript_include_tag "http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"
        else
            javascript_include_tag "jquery-1.6.2.min"
        end
    end

    def jquery_ui_include_tag
        if @site.use_external_jquery
            javascript_include_tag "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"
        else
            javascript_include_tag "jquery-ui-1.8.16.min"
        end
    end

    def error_message_on(object, method)
        if (obj = (object.respond_to?(:errors) ? object : instance_variable_get("@#{object}"))) &&
          (errors = obj.errors[method]).presence
          content_tag(:div, errors.first, :class => 'formError')
        else
          ''
        end
    end    

    private

    def rewriter
        caller_method = (caller[0] =~ /`([^']*)'/ and $1)
        rewriter_method = "rewriter_of_#{caller_method}"
        if @user.send("enable_#{rewriter_method}") && respond_to?(rewriter_method)
            send(rewriter_method).to_s.html_safe
        else
            yield
        end
    end

    def arounder(&block)
        caller_method = (caller[0] =~ /`([^']*)'/ and $1)
        before_method = "before_#{caller_method}".to_sym
        after_method  = "after_#{caller_method}".to_sym
        html = ""
        html << show_something(before_method)
        html << capture(&block)
        html << show_something(after_method)
        html.html_safe
    end
end
