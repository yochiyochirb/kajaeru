class EventPolicy < ApplicationPolicy
  def votable?
    record.voters.where(member_id: user.id).present?
  end
end
