class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.text :comment
      t.integer :voted_member_id, :null => false
      t.integer :voting_member_id :null =>false

      t.timestamps
    end
  end
end
