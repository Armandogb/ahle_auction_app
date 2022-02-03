class ApplicationController < ActionController::Base
  before_action :set_user

  private

  def set_user
    @user = current_user
  end

  def admin_check
    redirect_to root_path, alert: 'Action not permitted.' unless user_has_admin_role?
  end

end
