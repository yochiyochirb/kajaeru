class Member < ActiveRecord::Base
  validates :nickname, presence: true
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :image, presence: true
end
