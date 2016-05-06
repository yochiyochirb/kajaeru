class Voter < Role
  has_one :vote

  def voted_for?(event)
    vote.present? && in?(event.voters)
  end
end
