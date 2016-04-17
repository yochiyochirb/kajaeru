class Candidate < Role
  has_many :votes

  scope :for_this_event, -> (event) { where(event_id: event.id) }
end
