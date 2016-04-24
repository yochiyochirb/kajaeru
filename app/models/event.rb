class Event < ActiveRecord::Base
  has_many :candidates
  has_many :voters

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  scope :being_held, -> do
    where('starts_at < ? AND ends_at > ?', Time.zone.now, Time.zone.now)
  end

  # 開催期間中かどうか
  def in_session?
    Time.zone.now.between?(starts_at, ends_at)
  end
end
