class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :nickname, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
