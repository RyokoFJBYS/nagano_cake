class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_active])
  end

  def after_admin_sign_out_path_for(resource)
    new_admin_session_path
  end

  def after_customer_sign_out_path_for(resource)
    root_path
  end

end
