class Member < ActiveRecord::Base
  has_many :candidates
  has_many :voters

  def voter?
    voters.present?
  end

  def as_voter
    # TODO 複数 voter を持つようになったらどの voter を選択するか条件を追加する
    voters.first
  end
end
