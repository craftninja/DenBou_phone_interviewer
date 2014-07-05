class UsersController < ApplicationController

  include ActionView::Helpers::NumberHelper

  before_action :user_cookie_expired?
  before_action :validate_user, only: :show


  def show
    if current_user.phone_number
      @recordings = current_user.recordings.includes(:question).order(:created_at).reverse
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(:phone_number => cleaned_params)
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  private

  def strong_params
    params.require(:user).permit(phone_number: [:phone_number1, :phone_number2])
  end

  def cleaned_params
    strong_params["phone_number"]["phone_number1"] + strong_params["phone_number"]["phone_number2"].gsub("-","").delete(" ")
end

  def user_cookie_expired?
    unless current_user
      redirect_to root_path
    end
  end

  def validate_user
    render :status => :forbidden, :text => "Forbidden Fruit, my friend. Please visit your own profile page." unless current_user and current_user.id.to_s == params[:id]
  end
end