# Adjust sessions so they work across subdomains
# This also will work if your app runs on different TLDs

# from: http://szeryf.wordpress.com/2008/01/21/cookie-handling-in-multi-domain-applications-in-ruby-on-rails/
# modified to work with Rails 2.3.0

module ActionControllerExtensions
  def self.included(base)
    base::Dispatcher.send :include, DispatcherExtensions
  end

  module DispatcherExtensions
    def self.included(base)
      base.send :before_dispatch, :set_session_domain
    end

    def set_session_domain
      if @env['HTTP_HOST']
        # remove the port if there is one
        domain = @env['HTTP_HOST'].gsub(/:\d+$/, '')
        
        # turn "brendan.app.com" to ".app.com"
        # and turn "app.com" to ".app.com"
        if domain.match(/([^.]+\.[^.]+)$/)
          domain = '.' + $1
        end
        
        @env['rack.session.options'] = @env['rack.session.options'].merge(:domain => domain)
      end
    end
  end
end

ActionController.send :include, ActionControllerExtensions

