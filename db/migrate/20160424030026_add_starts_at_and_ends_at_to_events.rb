class AddStartsAtAndEndsAtToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :starts_at, :datetime, null: false, default: Time.at(0)
    add_column :events, :ends_at, :datetime, null: false, default: Time.at(0)
  end
end
