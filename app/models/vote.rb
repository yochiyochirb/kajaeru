class Vote < ActiveRecord::Base
  validates :voted_member_id,  presence: true
  validates :voting_member_id, presence: true, uniqueness: true

  belongs_to :voted_member,  foreign_key: 'voted_member_id',  class_name: Member
  belongs_to :voting_member, foreign_key: 'voting_member_id', class_name: Member
end
