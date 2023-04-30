class RemoveRoleIdIndexFromAccessControls < ActiveRecord::Migration[7.0]
  def change
    remove_index :access_controls, :role_id
  end
end
