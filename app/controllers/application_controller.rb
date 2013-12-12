class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :omniauth_external_providers?, :omniauth_provider?

  private

  # @return [Object]    Returns the current User Record
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def omniauth_external_providers?
    omniauth_provider?(:twitter) || omniauth_provider?(:facebook)
  end

  def omniauth_provider?(provider_sym)
    provider_env = provider_sym.to_s.upcase
    ENV["OC_#{provider_env}_ENABLE"].to_s.to_bool
  end

end
