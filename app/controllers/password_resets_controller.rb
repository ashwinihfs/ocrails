#
# The PasswordResetsController class is responsible  for all actions to do with the resetting of the user passwords
# stored by the Identity Model. Users are not able to reset any passwords when coming from an external provider
class PasswordResetsController < ApplicationController
  #
  # The new method is responsible for displaying the password reset form, where the user that has forgotten the password
  # will be given a chance to enter their e-mail address
  def new

  end

  #
  # The create action is where the password reset for will POST to. It checks to see if the user email
  # esists in the database, and then if so calles the appropriate send_password_reset email. It will then redirect to
  # the root_url with a message saying that the password reset instructions have been sent. It returns this message even
  # if the user email does not exist in the database, this cannot be used to confirm if an e-mail exists in the
  # database or not.
  def create
    identity = Identity.find_by_email(params[:email])
    identity.send_password_reset if identity
    redirect_to root_url, :notice => I18n.t('form.password_resets.notice.reset_password')
  end
  #
  # The edit action is where the user is sent after clicking the link in the password reset email - This finds the
  # password reset code in the database, and then displays the password reset form
  def edit
    @identity = Identity.find_by_password_reset_token!(params[:id])
  end

  #
  # The update action is given the password reset form input, it then checks to see that the password reset email was
  # not sent more than 4 hours ago (to prevent stale codes), and if it is less than 4 hours old it will reset the
  # passwords as required.
  def update
    @identity = Identity.find_by_password_reset_token!(params[:id])
    if @identity.password_reset_sent_at < 4.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired - Please generate a new one."
    elsif @identity.update(identity_params)
      redirect_to root_url, :notice => "Password has been reset."
    else
      render :edit
    end
  end

  private
  #
  # The identity_params method will permit the appropriate parameters to be whitelisted in Rails 4
  def identity_params
    params.require(:identity).permit(:password, :password_confirmation)
  end
end
