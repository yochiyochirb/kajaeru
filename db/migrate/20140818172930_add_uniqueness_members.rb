class AddUniquenessMembers < ActiveRecord::Migration
  def change
    add_index :members, [:nickname, :uid, :image], unique: true
  end
end
