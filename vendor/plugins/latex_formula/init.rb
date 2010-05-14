require "latex_formula"

config.load_paths += %W(#{LatexFormula::PLUGIN_CONTROLLER_PATH})

Rails::Initializer.run(:set_load_path, config)

require 'latex_formula_controller'

class ActionController::Routing::RouteSet
  unless (instance_methods.include?('draw_with_latex_formula'))
    class_eval <<-"end_eval", __FILE__, __LINE__  
      alias draw_without_latex_formula draw
      def draw_with_latex_formula
        draw_without_latex_formula do |map|
          map.connect '/latex_formula/make_png', :controller => 'latex_formula', :action => 'make_png'
          yield map
        end
      end
      alias draw draw_with_latex_formula
    end_eval
  end
end
