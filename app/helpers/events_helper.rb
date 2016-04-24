module EventsHelper
  def voting_period(event)
    "#{event.starts_at.strftime('%Y-%m-%d %H:%M:%S')}" \
    " 〜 #{event.ends_at.strftime('%Y-%m-%d %H:%M:%S')}"
  end
end
