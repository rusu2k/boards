class AddDefaultValueToColumnIdInStories < ActiveRecord::Migration[7.0]
  def change
    change_column_default :stories, :column_id, 1
  end
end
