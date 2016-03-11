class Voter < Role
  has_one :vote

  def casted_vote?
    Vote.exists?(voter: self)
  end
end
