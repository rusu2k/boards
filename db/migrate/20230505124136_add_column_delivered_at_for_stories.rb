class AddColumnDeliveredAtForStories < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :delivered_at, :datetime
  end
end
