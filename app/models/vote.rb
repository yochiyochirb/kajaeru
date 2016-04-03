class Vote < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :voter

  # TODO should be more DRY
  # サブクエリ使うより vote と event を関連させた方が直感的でよい？
  scope :for_this_event, -> (event) do
    Vote.where(candidate_id: event.candidates.select(:id))
  end

  def self.total(votes)
    # order('count_all') のイディオムはドキュメントにない (と思う) が、
    # ActiveRecord#column_alias_for のコードに "usable column name" として
    # 記載があるので利用することにする
    # vote_counts_and_candidates => [[5, 10], [3, 7], [2, 5], ...]
    candidates_and_totals = votes.group(:candidate_id)
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
