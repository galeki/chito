class Admin::UsersController < Admin::BaseController
    before_filter :chito_admin_authorize    
    in_place_edit_for :user, :bind_domain

  def index
    @users = User.users_in_admin(params)
    @groups = Group.order("id")
  end

  def set_group
    unless session[:user_id] == params[:id]
        @u = User.find(params[:id])
        @u.group_id = params[:group]
        if @u.save
            @setted = true
        end
    end
  end

  def destroy
    @user = User.find(params[:id])
    notice_stickie t(:user_deleted, :scope => [:txt, :controller, :admin, :users]) if @user.destroy
    redirect_to admin_users_path   
  end

end
