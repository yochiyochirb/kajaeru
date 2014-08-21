class Member < ActiveRecord::Base
  validates :nickname, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :uid,      presence: true, uniqueness: true
  validates :image,    presence: true, uniqueness: true

  def self.create_with_omniauth(auth)
    create! do |member|
      member.provider = auth['provider']
      member.uid      = auth['uid']
      member.nickname = auth['info']['nickname']
      member.image    = auth['info']['image']
    end
  end
end
