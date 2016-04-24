class EventPolicy < ApplicationPolicy
  def votable?
    record.in_session? && record.voters.where(member_id: user.id).present?
  end
end
