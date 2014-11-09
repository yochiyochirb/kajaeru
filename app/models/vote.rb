class Vote < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :voter

  def self.total
    vote_counts_and_users = group(:candidate_id).count(:voter_id).sort {|a, b| b[1] <=> a[1] }
    vote_counts_and_users.inject([]) do |vote_totals, vote_count_and_user|
      # vote_count_and_user => [5, 10]
      user_id,total = vote_count_and_user
      member  = Member.where(id: user_id).first
      vote_totals.push({
                      nickname: member[:nickname],
                      image:    member[:image],
                      total:    total,
                      comments: where(candidate_id: user_id).pluck(:comment)
                      })
    end
  end

  def self.user_voted?(user_id)
    Vote.exists?(voting_member_id: user_id)
  end
end
