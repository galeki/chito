class Admin::UsersController < Admin::BaseController
    before_filter :chito_admin_authorize    
    in_place_edit_for :user, :bind_domain

  def index
    @users = User.users_in_admin(:page => params[:page], :name => params[:name])
    @groups = Group.find(:all)
  end

  def set_group
    unless session[:user_id] == params[:id]
	@u = User.find(params[:id])
	@u.group_id = params[:group]
	@u.save
	render :update do |page|
	    page.visual_effect :highlight, "user#{@u.id}_group", :startcolor => '#ffff00',
			       :endcolor => '#ffffff',
			       :duration => 3.0
	end
    end
  end

  def destroy
    @user = User.find(params[:id])
    notice_stickie t(:user_deleted, :scope => [:txt, :controller, :admin, :users]) if @user.destroy
    redirect_to admin_users_path   
  end

end
