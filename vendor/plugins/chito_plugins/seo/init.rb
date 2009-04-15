require 'seo'

plugin = ChitoPlugin.new do
    self.id = "seo"
    self.name = "SEO"
    self.version = "1.0.1"
    self.writer = "galeki"
    self.web = "http://galeki.net"
    self.contributers = ""
    self.category = ""
    self.info = ""
end
ChitoPlugin.add(plugin)
#class ActionController::Routing::RouteSet
#  unless (instance_methods.include?('draw_with_seo'))
#    class_eval <<-"end_eval", __FILE__, __LINE__  
#      alias draw_without_seo draw
#      def draw_with_seo
#        draw_without_seo do |map|
#          map.connect ':user_name/article/:id/:seo_title.:format', :controller => 'blog', :action => 'show'
#          yield map
#        end
#      end
#      alias draw draw_with_seo
#    end_eval
#  end
#end
