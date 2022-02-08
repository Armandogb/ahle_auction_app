class ApplicationController < ActionController::Base
  before_action :set_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_user
    @user = current_user

    if @user.present?
      session[:user_id] = @user.id
    end
  end

  def admin_check
    redirect_to root_path, alert: 'Action not permitted.' unless  current_user.present? && current_user.has_role?(:admin)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :sign_up_code, :first_name, :last_name])
  end

end
