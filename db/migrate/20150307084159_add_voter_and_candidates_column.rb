class AddVoterAndCandidatesColumn < ActiveRecord::Migration
  def change
    remove_column :votes, :voted_member_id
    remove_column :votes, :voting_member_id
    add_column :votes, :voter_id, :integer
    add_column :votes, :candidate_id, :integer
  end
end
