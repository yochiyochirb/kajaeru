class Member < ActiveRecord::Base
  has_many :candidates
  has_many :voters

  # returns voter if found otherwise nil
  def as_voter_for(event)
    event.voters.where(member_id: id).first
  end
end
