module NavbarHelper

    def navbar 
	@enable_navbars
    end

    def link_to_nav(navbar, options={})
	if navbar.page
            link_to_nav_page(navbar, options)
	else
            link_to_nav_link(navbar, options)
	end
    end

    def link_to_nav_page(navbar, options={})
	link_to navbar.title, pagepath(navbar.page),
                :class => (options[:selected_class] if current(navbar)),
		:id => (options[:selected_id] if current(navbar))
    end

    def link_to_nav_link(navbar, options={})
	if navbar.url.is_a?(Hash) && request.domain == @site.domain
            navbar.url.merge! :subdomain => (session[:user_name] || 'www') 
        end
	link_to (options[:text] || navbar.title), navbar.url,
		:class => (options[:selected_class] if current(navbar)),
		:id => (options[:selected_id] if current(navbar))
    end

    def current(nav)
        if nav.page
	    params[:id] == nav.id.to_s || (params[:permalink] && params[:permalink] == nav.page.permalink)
        else
            request.fullpath == nav.url
        end
    end

    def pagepath(page)
	page.permalink.blank? ? page_path(page, :format => :html) : page_permalink_path(page.permalink)
    end
end
