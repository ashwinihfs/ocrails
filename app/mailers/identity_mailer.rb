class IdentityMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.identity_mailer.password_reset_email.subject
  #
  def password_reset_email(identity)
    @identity = identity
    mail to: "#{identity.email}", subject: "Password Reset Request"
  end
end
