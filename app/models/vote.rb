class Vote < ActiveRecord::Base
  validates :voted_member_id, presence: true
  validates :voting_member_id, presence: true, uniqueness: true
end
