class Voter < Role
  has_one :vote

  def voted?
    vote.present?
  end
end
