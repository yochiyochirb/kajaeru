class RenameStartsAtAndEndsAtColumnsToEvents < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :starts_at, :voting_starts_at
    rename_column :events, :ends_at, :voting_ends_at
  end
end
