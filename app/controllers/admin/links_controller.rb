class Admin::LinksController < Admin::BaseController
        in_place_edit_for :link, :title
        in_place_edit_for :link, :url
        in_place_edit_for :link, :info
        after_filter(:except => :index) { |c| c.sidebar_cache_expire :links }

  def index
    @links = @user.links
  end

  def set_position
    @links = @user.links
    params[:all_links].each_with_index do |id,idx| 
        @link = @links.find(id) 
        @link.update_attributes(:position => idx) if @link
    end
  end

  def create
    @link = @user.links.new(params[:link])
    if @link.save
        @created = true
    else
        error_stickie(@link.errors.full_messages * "; ")
    end
  end

  def destroy
    @user.links.find(params[:id]).destroy
    notice_stickie t( :link_successfully_deleted, :scope => [:txt, :controller, :admin, :links])    
    redirect_to admin_links_path
  end

end
