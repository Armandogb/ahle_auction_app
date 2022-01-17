class ApplicationController < ActionController::Base

  private

  def admin_check
    redirect_to root_path, alert: 'Action not permitted.' unless user_has_admin_role?
  end
end
