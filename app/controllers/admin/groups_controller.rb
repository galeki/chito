class Admin::GroupsController < Admin::BaseController
    before_filter :chito_admin_authorize
    in_place_edit_for :group, :name
    in_place_edit_for :group, :space
    in_place_edit_for :group, :file_size_limit

  def index
    @groups = Group.order("id")
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
	render :update do |page|
	    page.insert_html :top, "all_groups", :partial => "group" 
	    page.visual_effect :highlight, "group_#{@group.id}", :startcolor => '#ffff00',
			       :endcolor => '#ffffff',
			       :duration => 5.0
	end
    else
	error_stickie @group.errors.full_messages
 	render :update do |page|
 	  page.replace_html "updater", :partial => "share/error" 
	  page.visual_effect :BlindDown, "updater"
         end
    end

  end

  def destroy
    group = Group.find(params[:id])
    if group.deletable? 
	group.destroy 
	notice_stickie t(:group_deleted, :scope => [:txt, :controller, :admin, :groups])
    else
	error_stickie  t(:no_delete, :scope => [:txt, :controller, :admin, :groups])
    end
    redirect_to admin_groups_path
  end

end
