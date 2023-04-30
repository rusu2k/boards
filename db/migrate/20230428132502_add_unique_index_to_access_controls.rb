class AddUniqueIndexToAccessControls < ActiveRecord::Migration[7.0]
  def change
    add_index :access_controls, [:role_id, :action_id], unique: true
  end
end
