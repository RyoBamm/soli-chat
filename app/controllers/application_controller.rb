class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :age, :avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :age, :avatar, :profile, :prefecture_id])
    end
end
