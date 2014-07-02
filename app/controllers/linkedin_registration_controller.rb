class LinkedinRegistrationController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.create_or_update_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to edit_user_path(user)
  end

end