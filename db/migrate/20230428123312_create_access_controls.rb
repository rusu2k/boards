class CreateAccessControls < ActiveRecord::Migration[7.0]
  def change
    create_table :access_controls do |t|
      t.references :role, null: false, foreign_key: true
      t.references :action, null: false, foreign_key: true

      t.timestamps
    end
  end
end
