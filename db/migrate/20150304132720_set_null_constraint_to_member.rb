class SetNullConstraintToMember < ActiveRecord::Migration
  def up
    change_column_null :members, :created_at, false
    change_column_null :members, :updated_at, false
  end

  def down
    change_column_null :members, :created_at, true
    change_column_null :members, :updated_at, true
  end
end
