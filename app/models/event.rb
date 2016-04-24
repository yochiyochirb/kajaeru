class Event < ActiveRecord::Base
  has_many :candidates
  has_many :voters

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  # 開催期間中かどうか
  def in_session?
    Time.zone.now.between?(starts_at, ends_at)
  end
end
