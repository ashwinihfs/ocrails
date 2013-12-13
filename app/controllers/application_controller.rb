class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :omniauth_external_providers?, :omniauth_provider?

  private


  #
  # The current_user method is responsible from finding the currently logged in user record based on the user_id
  # session cookie
  #
  # @return [Object]    Returns the current User Record
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  #
  # The omniauth_external_providers? method checks to see if any supported external providers are enabled, and if so
  # will return a true value, otherwise it returns false. This is defined as a helper method so it can be used in views
  # as a flag to conditionally display parts of the sessions controller views
  #
  # @return [Boolean] True if there are external providers enabled, false otherwise
  def omniauth_external_providers?
    omniauth_provider?(:twitter) || omniauth_provider?(:facebook)
  end
  #
  # The omniauth_provider? checks to see if there is a environment variable named OC_provider_ENABLE (for
  # example OC_TWITTER_ENABLE). If this value is present, it is checked to see if it is true, yes, or 1, if so,
  # this method will return TRUE, otherwise it will return FALSE.
  # This is defined as a helper method so it can be used in views
  # as a flag to conditionally display parts of the sessions controller views
  #
  # @param [Object] provider_sym A Symbol representation of the provider to be checked
  # @return [Boolean] True if the environment variable OC_provider_ENABLE variable is present. (For example OC_TWITTER_ENABLE)
  def omniauth_provider?(provider_sym)
    provider_env = provider_sym.to_s.upcase
    ENV["OC_#{provider_env}_ENABLE"].to_s.to_bool
  end

end
