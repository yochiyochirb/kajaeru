class Event < ActiveRecord::Base
  has_many :candidates
  has_many :voters

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
