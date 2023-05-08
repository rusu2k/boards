class AddIndexToStories < ActiveRecord::Migration[7.0]
  def change
    add_index :stories, %i[board_id column_id]
    add_index :stories, %i[board_id user_id]
  end
end
