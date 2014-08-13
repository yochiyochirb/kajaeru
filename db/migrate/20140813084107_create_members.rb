class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :nickname
      t.string :provider
      t.string :uid
      t.string :image

      t.timestamps
    end
  end
end
