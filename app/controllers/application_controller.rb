class ApplicationController < ActionController::Base
  before_action :set_user

  private

  def set_user
    if current_user.present?
      @user = current_user
    else
      @user = nil
    end
  end

  def admin_check
    redirect_to root_path, alert: 'Action not permitted.' unless user_has_admin_role?
  end

end
