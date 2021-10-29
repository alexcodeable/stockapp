class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      added_attrs = [:username, :email, :bio, :avatar, :first_name, :last_name, :name, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :name, :password, :password_confirmation, :remember_me])
      devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
end
