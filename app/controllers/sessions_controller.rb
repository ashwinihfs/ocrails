class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Hello #{user.name} - You are now Signed In"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Goodbye - You are now Signed Out"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end
