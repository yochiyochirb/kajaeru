class Event < ActiveRecord::Base
  validates :name, null: false, uniqueness: true
end
