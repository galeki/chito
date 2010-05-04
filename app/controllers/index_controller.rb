class IndexController < ApplicationController
  include IndexControllerPlugin 
  self.prepend_view_path(IndexTheme::PATH) 

  def index
    if @site.show_index?(request)
        @show_index = true
        @posts = Article.find(:all, :order => "created_at desc", :limit => 20)
        get_index_sidebars
        do_something :before_index_show
    else
        internal_redirect_to :controller => "posts", :action => "index"
    end
  end

  private 

  def render(options = {}, extra_options = {}, &block)
    @theme = @site.index_theme || "is-programmer"
    if @theme 
   	layout = "#{@theme}/layouts/#{@theme}"
	template = "#{@theme}/views/#{controller_name}/#{action_name}"
	template_path = File.join(IndexTheme::PATH, template + ".html.erb" )
	super :template => template, :layout => layout
    else
	super(options, extra_options, &block)
    end
  end

  def internal_redirect_to (options={})
    params.merge!(options)
    (c = ActionController.const_get("PostsController").new).process(request,response)
    c.instance_variables.each{|v| self.instance_variable_set(v,c.instance_variable_get(v))} 
  end
  

end

