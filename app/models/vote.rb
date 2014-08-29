class Vote < ActiveRecord::Base
  validates :voted_member_id,  presence: true
  validates :voting_member_id, presence: true, uniqueness: true

  def self.total
    vote_counts_and_users = group(:voted_member_id).count(:voted_member_id).sort{|a,b| b[1]<=>a[1]}
    vote_counts_and_users.inject([]) do |vote_totals, vote_count_and_user|
      # vote_count_and_user => [5, 10]
      user_id,total = vote_count_and_user
      member  = Member.where(id: user_id).first
      vote_totals.push({
                      nickname: member[:nickname],
                      image:    member[:image],
                      total:    total,
                      comments: where(voted_member_id: user_id).pluck(:comment)
                      })
    end
  end
end
