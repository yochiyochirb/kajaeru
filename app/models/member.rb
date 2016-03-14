class Member < ActiveRecord::Base
  # validates :nickname, presence: true, uniqueness: true
  # validates :provider, presence: true
  # validates :uid,      presence: true, uniqueness: true
  # validates :image,    presence: true, uniqueness: true

  has_many :roles
  # XXX なんだろう以下のコード、あってるんだろうか？
  # has_many :candidate, -> { roles.where(_type: 'Candidate') }

  def as_voter
    Voter.find_by(member_id: id)
  end

  def as_candidate
    Candidate.find_by(member_id: id)
  end
end
