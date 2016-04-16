class Member < ActiveRecord::Base
  has_many :candidates
  has_many :voters
end
