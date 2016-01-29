class LandingController < ApplicationController

  def welcome    
  end

  def index
  end

  def subscription
    if current_user
      flash[:notice] = "Thank you for subscribing!"
      redirect_to user_path current_user
    else
      flash[:notice] = "Thank you for subscribing, please log in!"
      redirect_to welcome_path
    end
  end

  def terms
  end
end
