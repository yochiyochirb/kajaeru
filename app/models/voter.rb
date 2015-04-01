class Voter < Role
  has_one :vote
  # XXX 関連名とメソッド名がかぶった時ってどうしたらいいんだろう
  # XXX 本当は do_vote の引数は @vote じゃなくて candidate にしたい
  # あーでも comment とかもあるからなあ…こっちで保存するのどうしよう
  def do_vote(candidate)
    # TODO 既に投票していたら、投票できない
    #Vote.create!(voter_id: self.id, candidate_id: candidate.id, comment
  end
end
