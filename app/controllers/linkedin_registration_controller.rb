class LinkedinRegistrationController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.create_or_update_with_omniauth(auth)
    cookies.signed[:user_id] = { :value => user.id, :expires => 60.days.from_now }
    redirect_to edit_user_path(user)
  end

end