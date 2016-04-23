class AddTotalOpenedToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :total_opened, :boolean, null: false, default: false
  end
end
