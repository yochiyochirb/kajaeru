class AddReferencesToEventToRoles < ActiveRecord::Migration[5.0]
  def change
    add_reference :roles, :event, foreign_key: true
  end
end
