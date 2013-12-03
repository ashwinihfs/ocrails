OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['OC_TWITTER_KEY'], ENV['OC_TWITTER_SECRET']
  provider :facebook, ENV['OC_FACEBOOK_KEY'], ENV['OC_FACEBOOK_SECRET']
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end
