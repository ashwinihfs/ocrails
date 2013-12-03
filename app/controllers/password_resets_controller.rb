class PasswordResetsController < ApplicationController
  def new

  end

  def create
    identity = Identity.find_by_email(params[:email])
    identity.send_password_reset if identity
    redirect_to root_url, :notice => I18n.t('form.password_resets.notice.reset_password')
  end

  def edit
    @identity = Identity.find_by_password_reset_token!(params[:id])
  end

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
  def identity_params
    params.require(:identity).permit(:password, :password_confirmation)
  end
end
