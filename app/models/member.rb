class Member < ActiveRecord::Base
  # validates :nickname, presence: true, uniqueness: true
  # validates :provider, presence: true
  # validates :uid,      presence: true, uniqueness: true
  # validates :image,    presence: true, uniqueness: true

  has_many :roles
  # XXX なんだろう以下のコード、あってるんだろうか？
  # has_many :candidate, -> { roles.where(_type: 'Candidate') }

  def casted_vote?
    Vote.exists?(voter: self)
  end
end
