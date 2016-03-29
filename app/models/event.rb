class Event < ActiveRecord::Base
  has_many :roles

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
