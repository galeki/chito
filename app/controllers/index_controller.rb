class IndexController < ApplicationController
  include IndexControllerPlugin 
  self.prepend_view_path(IndexTheme::PATH) 
  before_filter :get_index
  before_filter :get_index_needed, :except => [:plugin_css]

  def index
    if @index
        @posts = Article.new_ranked_posts :rank => 0, 
                                          :index_id => @index.id,
                                          :page => params[:page], 
                                          :per_page => @index.new_post_number.to_num(10)
        respond_to do |format|
	    format.html do
                get_index_sidebars
                do_something :before_index_show
	    end
	    format.rss
        end
    else
        internal_redirect_to :controller => "posts", :action => "index"
    end
  end

  def plugin_css
    send_data @index.plugin_css.to_s, :type => 'text/css', :disposition => 'inline'  
  end

  private 

  def get_index
    @index = @site.get_index(request)
  end

  def get_index_needed
    I18n.locale = "zh-CN" #TODO
    @theme = @index.theme || "spheroids"
  end

  def render(options = {}, extra_options = {}, &block)
    if @theme && (params[:format].nil? or params[:format] == "html")
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
    (c = PostsController.new).process(request,response)
    c.instance_variables.each{|v| self.instance_variable_set(v,c.instance_variable_get(v))} 
  end
  

end

