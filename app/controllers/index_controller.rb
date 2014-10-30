class IndexController < ApplicationController
  include IndexControllerPlugin 
  self.prepend_view_path(IndexTheme::PATH) 
  before_filter :get_index

  def index
    get_index_needed
    respond_to do |format|
        format.html do
            @posts = Article.new_ranked_posts :rank => 0, 
                                          :index_id => @index.id,
                                          :keyword => params[:is],
                                          :page => params[:page], 
                                          :per_page => @index.new_post_number.to_num(10)
            get_index_sidebars
            do_something :before_index_show
        end

        format.rss do
            @posts = Article.new_posts(5).where("articles.index_id = ?", @index.id)
        end
    end
  end

  def plugin_css
    send_data @index.plugin_css.to_s, :type => 'text/css', :disposition => 'inline'  
  end

  private

  def get_index
    @index = @site.index
    raise "no index" unless @index
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
        super
    end
  end

end

