#
# The Identity Model holds all the logic for the Omniauth Local Identity (Name/Password) Functionality

class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates_presence_of :name
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\Z/i

  #
  # The send_password_reset method will generate a unique password_reset_token, and then e-mail the result to the user
  # via the IdentityMailer module
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    IdentityMailer.password_reset_email(self).deliver
  end
  #
  # the generate_token method uses the built_in SecureRandom method to generate a url_save random string, encoded as
  # base-64, stores this in the database column.
  #
  # @param [Object] column     Column Name to store the reset token in (in Identity Table)
  # @return [Nothing]
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Identity.exists?(column => self[column])
  end
end
