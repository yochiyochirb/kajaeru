class Member < ActiveRecord::Base
  has_one :candidate
  has_one :voter
end
