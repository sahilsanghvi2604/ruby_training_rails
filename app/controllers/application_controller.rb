class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Created for giving permission to save attributes while register and login.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [ :first_name, :last_name, :phone_number, :age, :date_of_birth ]
    )
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [ :first_name, :last_name, :phone_number, :age, :date_of_birth ]
    )
  end
end
