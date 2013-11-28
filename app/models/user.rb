class User < ActiveRecord::Base

  validates_presence_of :provider, :message => 'must be specified'
  validates_presence_of :uid, :message => 'must be specified'
  validates_presence_of :name, :message => 'must be specified'

  def self.from_omniauth(authentication)
    where(authentication.slice('provider', 'uid')).first ||
        create_user_from_omniauth(authentication)
  end

  def self.create_user_from_omniauth(authentication)
    create! do |user|
      user.provider = authentication['provider']
      user.uid = authentication['uid']
      user.name = authentication['info']['name']
    end
  end

end
