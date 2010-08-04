module ApplicationHelper
    include TagsHelper
    include ApplicationHelperPlugin

    def render_flash(options={})
	render_stickies({:close => t("txt.close") }.update(options)).html_safe
    end

    def chito_cache(options={}, &block)
	cache( chito_cache_key(options), &block )
    end

    def sidebar_cache(id, options={}, &block)
	cache chito_cache_key(options.merge(:part => :plugins, :type => :sidebars, :id => id)), &block 
    end

    def jquery_include_tag
	if @site.use_external_jquery
           javascript_include_tag "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"
        else
	    javascript_include_tag "jquery"
        end
    end

    def jquery_ui_include_tag
	if @site.use_external_jquery
	    javascript_include_tag "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"
        else
	    javascript_include_tag "jquery-ui"
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
