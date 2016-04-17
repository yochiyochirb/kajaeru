class Vote < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :voter

  scope :for_this_event, -> (event) do
    where(candidate_id: event.candidates.select(:id))
  end

  scope :by_member, -> (member) { where(voter_id: member.voters.select(:id)) }

  def self.total(event:)
    # order('count_all') のイディオムはドキュメントにない (と思う) が、
    # ActiveRecord#column_alias_for のコードに "usable column name" として
    # 記載があるので利用することにする
    # vote_counts_and_candidates => [[5, 10], [3, 7], [2, 5], ...]
    candidates_and_totals = for_this_event(event).group(:candidate_id)
                                                 .order('count_all desc')
                                                 .count

    # TODO ここはデコレータ的にやりたい感
    candidates_and_totals.inject([]) do |totals, candidate_and_total|
      candidate_id, total = candidate_and_total
      member = Candidate.find(candidate_id).member
      totals.push(
        nickname: member[:nickname],
        image:    member[:image],
        total:    total,
        comments: where(candidate_id: candidate_id).pluck(:comment)
      )
    end
  end
end
