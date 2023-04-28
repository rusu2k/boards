class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.date :due_date
      t.text :details
      t.references :column, null: false, foreign_key: true

      t.timestamps
    end
  end
end
