class Member < ActiveRecord::Base
  validates :nickname, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :uid,      presence: true, uniqueness: true
  validates :image,    presence: true, uniqueness: true

  has_many :voteds, foreign_key: 'voted_member_id', class_name: Vote
  has_many :votings, foreign_key: 'voting_member_id', class_name: Vote
end
