class Vote < ActiveRecord::Base
  validates :uid, presence: true
  validates :image, presence: true
end
