class AddUniquenessVotes < ActiveRecord::Migration
  def change
    add_index :votes, :voting_member_id, unique: true
  end
end
