class WelcomeController < ApplicationController

  def index
    if current_user
      redirect_to user_path(current_user)
    else
      render 'index', layout: 'homepage'
    end
  end

end