#
# The User model is the interace to the User Database.
#
# Most of the Information is processed by the omniauth system, so this table only contains a list of provider name,
# and user identifiers (uid).
class User < ActiveRecord::Base

  validates_presence_of :provider, :message => 'must be specified'
  validates_presence_of :uid, :message => 'must be specified'
  validates_presence_of :name, :message => 'must be specified'

  #
  # The from_omniauth method tries to see if there is a user record with the provider and uid, where it will return
  # the record, otherwise it will call the create_user_from_omniauth method to create the user record locally
  #
  #
  # @param [Object] authentication      An OmniAuth Authentication Hash
  # @return [Object]                    The User Record
  def self.from_omniauth(authentication)
    where(authentication.slice('provider', 'uid')).first ||
        create_user_from_omniauth(authentication)
  end
  #
  # The create_user_from_omniauth method taked the OmniAuth provided authentication hash, and will create a user record
  #
  # @param [Object] authentication      An OmniAuth Authentication Hash
  # @return [Nothing]
  def self.create_user_from_omniauth(authentication)
    create! do |user|
      user.provider = authentication['provider']
      user.uid = authentication['uid']
      user.name = authentication['info']['name']
    end
  end

end
