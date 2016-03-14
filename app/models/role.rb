require 'forwardable'

class Role < ActiveRecord::Base
  # NOTE Role (Candidate/Voter) から透過的に Member の属性に
  #      アクセスするために delegation を利用する
  extend Forwardable
  def_delegators :member, :nickname, :image

  belongs_to :member
end
