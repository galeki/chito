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
        @created = true
    else
        error_stickie(@group.errors.full_messages * "; ")
    end
  end

  def set_api_status
    @group = Group.find(params[:id])
    @group.api_enable = (params[:enable] == "true" ? true : false)
    @group.save
  end

  def set_no_index_status
    @group = Group.find(params[:id])
    @group.no_index = (params[:enable] == "true" ? true : false)
    @group.save
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
