module NavbarHelper

    def navbar 
	@enable_navbars
    end

    def link_to_nav(navbar, options={})
	if navbar.page
	    link_to options[:text] || h(navbar.title), pagepath(navbar.page),
		    :class => (options[:selected_class] if current(navbar)),
		    :id => (options[:selected_id] if current(navbar))
	else
	    navbar.url.merge! :subdomain => session[:user_name] if navbar.url.is_a?(Hash) && request.domain == @site.domain
	    link_to options[:text] || h(navbar.title), navbar.url,
		    {:class => (options[:selected_class] if current(navbar)),
		    :id => (options[:selected_id] if current(navbar))}
	end
    end

    def current(nav)
	nav.page ? (params[:id] == nav.id.to_s || params[:permalink] == nav.page.permalink) : request.request_uri == nav.url
    end

    def pagepath(page)
	page.permalink.blank? ? page_path(page, :format => :html) : page_permalink_path(page.permalink)
    end
end
