class Admin::BaseController < ApplicationController
        before_filter :admin_authorize, :admin_subdomain_check, :get_locale, :get_time_zone
        layout "admin"

 private

  def bad_param(param)
    !param.match(/^[a-zA-Z0-9_]+$/)
  end

  def update_user_and_redirect_to(target, notice = nil , error = nil)
    notice ||= t(:config_updated, :scope => [:txt, :controller, :admin, :base])
    error ||= t(:config_not_saved, :scope => [:txt, :controller, :admin, :base])
    @user.update_attributes(params[:user]) ? notice_stickie(notice) : error_stickie(error)
    expire_chito_fragment
    redirect_to :action => target
  end

  def expire_chito_fragment
    if params[:expire_requests]
        params[:expire_requests].each do |key|
            key = Regexp.new(key) if key =~ /\*$/
            expire_fragment(key)
        end
    end
  end

  def check_rank_authorize(index_id)
    return true if @user.is_chito_admin?
    return true if @user.indices.find(index_id)
    return false
  end

end
