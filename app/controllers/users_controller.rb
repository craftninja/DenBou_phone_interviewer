class UsersController < ApplicationController

  def show

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(strong_params)
    flash[:phone_number_added] = "Thank you for adding your phone number. The phone number you added was: #{@user.phone_number}."
    redirect_to user_path(@user)
  end

  private

  def strong_params
    params.require(:user).permit(:phone_number)
  end

end