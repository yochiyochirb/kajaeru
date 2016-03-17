class Role < ActiveRecord::Base
  # NOTE Role (Candidate/Voter) から透過的に Member の属性に
  #      アクセスするために delegation を利用する
  delegate :nickname, :image, to: :member

  belongs_to :member
end
