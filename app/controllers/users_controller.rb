class UsersController < ApplicationController

  include ActionView::Helpers::NumberHelper

  def show
    @recordings = current_user.recordings.includes(:question)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(strong_params)
      formatted_phone_number = number_to_phone(@user.phone_number, area_code: true)
      flash[:phone_number_added] = "Thank you for adding your phone number. The phone number you added was: #{formatted_phone_number}."
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  private

  def strong_params
    params.require(:user).permit(:phone_number)
  end

end