class AddUniquenessToUid < ActiveRecord::Migration
  def change
    add_index :members, :uid, unique: true
  end
end
