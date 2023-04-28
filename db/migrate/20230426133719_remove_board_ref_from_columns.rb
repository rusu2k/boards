class RemoveBoardRefFromColumns < ActiveRecord::Migration[7.0]
  def change
    remove_reference :columns, :board, foreign_key: true
  end
end
