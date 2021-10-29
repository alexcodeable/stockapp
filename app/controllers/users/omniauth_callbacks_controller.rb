class Users::OmniauthCallbacksController < ApplicationController
    def google
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @user = User.from_omniauth(request.env["omniauth.auth"])
    
        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
          flash[:notice] = "Signed in successfully. " if is_navigational_format?
        else
          session["devise.google_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
          redirect_to new_user_registration_url
        end
      end
    
      def failure
        flash[:alert] = 'There was a problem signing you in. Please register or try signing in later.'
        redirect_to root_path
      end
end
