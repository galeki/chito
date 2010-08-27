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
    render :update do |page|
	page.replace_html "updater", :partial => "link_position"
	page.visual_effect :highlight, "position_update", :startcolor => '#ffff00',
			   :endcolor => '#ffffff',
			   :duration => 3.0		
    end
  end

  def create
    @link = @user.links.new(params[:link])
    if @link.save
	render :update do |page|
	    page.insert_html :top, "all_links", :partial => "link" 
	    page.call "clean_link_field"
	    page.visual_effect :highlight, "link_#{@link.id}", :startcolor => '#ffff00',
			       :endcolor => '#ffffff',
			       :duration => 5.0
	end
    else
	error_stickie(@link.errors.full_messages * "; ")
 	render :update do |page|
 	  page.replace_html "updater", :partial => "share/error" 
	  page.visual_effect :BlindDown, "updater"
         end	
    end
  end

  def destroy
    @user.links.find(params[:id]).destroy
    notice_stickie t( :link_successfully_deleted, :scope => [:txt, :controller, :admin, :links])    
    redirect_to admin_links_path
  end

end
