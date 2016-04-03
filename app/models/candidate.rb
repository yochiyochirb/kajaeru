class Candidate < Role
  has_many :votes

  # TODO should be more DRY
  scope :for_this_event, -> (event) { where(event_id: event.id) }
end
