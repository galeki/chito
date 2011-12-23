class Admin::PluginsController <  Admin::BaseController

  def index
    @plugins = ChitoPlugin.plugins_has_config
    @p = ChitoPlugin.find(params[:plugin_id]) #if params[:plugin_id]
  end

  def plugin
    return unless request.post?
    @user.update_attributes(params[:user]) ? (notice_stickie t(:plugin_updated, :scope => [:txt, :controller, :admin, :plugins])) : 
                                             (error_stickie t(:plugin_not_save, :scope => [:txt, :controller, :admin, :plugins]))
    expire_chito_fragment
    redirect_to :action => 'index', :plugin_id => params[:plugin_id]
  end

  def remote_form 
    return if bad_param(params[:plugin]) or bad_param(params[:view])
    @index = Index.find(params[:index_id]) if params[:index_id]
    path = "#{params[:plugin]}/app/views/#{params[:view]}"
    render :partial => path
  end

  def remote_update
    return unless request.xhr?
    if params[:index]
        @index = Index.find(params[:index_id])
        if @index && check_rank_authorize(@index.id)
            @index.update_attributes(params[:index])
        end
    else
        @user.update_attributes(params[:user]) 
        expire_chito_fragment
    end
  end

end
