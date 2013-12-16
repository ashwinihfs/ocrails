#
# The SessionsController class is responsible for all aspects of managing a user session (sign on).
#
# Since this is based around the omniauth library, it is pretty small, as most of the logic is provided by the OmniAuth
# gems
class SessionsController < ApplicationController
  #
  # The new action displays the sign on page with a list of the available external providers (if configured), or a
  # prompt to log in with a user name and password
  #
  # @return [Nothing]
  def new

  end

  #
  # The create action takes in the parameters passed in the system environment frm the omniauth process, and attempts
  # to find a user record with the provider service, and the user id. If it is found,, the user session cookie is set
  # to indicate the user is signed in

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
