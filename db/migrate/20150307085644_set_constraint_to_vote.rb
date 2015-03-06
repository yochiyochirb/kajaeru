class SetConstraintToVote < ActiveRecord::Migration
  def change
    change_column :votes, :voter_id, :integer, null: false
    change_column :votes, :candidate_id, :integer, null: false
    change_column :votes, :created_at, :datetime, null: false
    change_column :votes, :updated_at, :datetime, null: false
  end
end
