class Vote < ActiveRecord::Base
  validates :voted_member_id,  presence: true
  validates :voting_member_id, presence: true, uniqueness: true

  def self.sum_up
    group(:voted_member_id).count(:voted_member_id).inject(Array.new) do |voute_totals, elem|
      # elem => [5, 10]
      user_id,total = elem
      member  = Member.where(id: user_id).first
      voute_totals.push(Hash[
                      nickname: member[:nickname],
                      image:    member[:image],
                      score:    total,
                      comments: where(voted_member_id: user_id).pluck(:comment)
                      ])
    end
  end
end
