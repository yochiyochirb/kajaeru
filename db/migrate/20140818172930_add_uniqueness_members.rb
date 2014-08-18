class AddUniquenessMembers < ActiveRecord::Migration
  def change
    add_index :members, [:nickname, :uid, :image], unique: true, name: 'members_unique_index'
  end
end
