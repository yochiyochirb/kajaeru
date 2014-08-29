class Vote < ActiveRecord::Base
  validates :voted_member_id,  presence: true
  validates :voting_member_id, presence: true, uniqueness: true

  def self.total
    vote_counts = group(:voted_member_id).count(:voted_member_id).sort{|a,b| a[1]<=>b[1]}
    vote_counts.inject(Array.new) do |vote_totals, elem|
      # elem => [5, 10]
      user_id,total = elem
      member  = Member.where(id: user_id).first
      vote_totals.push(Hash[
                      nickname: member[:nickname],
                      image:    member[:image],
                      score:    total,
                      comments: where(voted_member_id: user_id).pluck(:comment)
                      ])
    end
  end
end
