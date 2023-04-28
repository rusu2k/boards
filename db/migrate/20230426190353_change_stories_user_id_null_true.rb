class ChangeStoriesUserIdNullTrue < ActiveRecord::Migration[7.0]
  def change
    change_column_null :stories, :user_id, true
    change_column_default :stories, :user_id, nil
  end
end
