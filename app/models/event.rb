class Event < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
