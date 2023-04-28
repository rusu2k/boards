class AddUserRefToStories < ActiveRecord::Migration[7.0]
  def change
    add_reference :stories, :user, foreign_key: true
  end
end
