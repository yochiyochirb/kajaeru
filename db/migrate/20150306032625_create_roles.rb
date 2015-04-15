class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :member, null: false
      t.string     :type, null: false

      t.timestamps null: false
    end
  end
end
