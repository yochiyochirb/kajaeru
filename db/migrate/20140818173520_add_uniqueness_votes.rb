class AddUniquenessVotes < ActiveRecord::Migration
  def change
    add_index :votes, :voting_member_id, unique: true, name: 'votes_unique_index'
  end
end
