class Event < ActiveRecord::Base
  validates :name, null: false, uniqueness: true

  has_many :users
  has_many :voting_papers
end
