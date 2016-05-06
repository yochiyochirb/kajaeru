module EventsHelper
  def voting_period(event)
    "#{event.voting_starts_at.strftime('%Y-%m-%d %H:%M:%S')}" \
    " 〜 #{event.voting_ends_at.strftime('%Y-%m-%d %H:%M:%S')}"
  end
end
