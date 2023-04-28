class AddUniqueIndexToBoardSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_index :board_subscriptions, [:user_id, :board_id], unique: true
  end
end
