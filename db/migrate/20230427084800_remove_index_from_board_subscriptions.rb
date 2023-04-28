class RemoveIndexFromBoardSubscriptions < ActiveRecord::Migration[7.0]
  def change
    remove_index :board_subscriptions, :user_id
  end
end
