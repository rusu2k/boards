class Story < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2, maximum: 100 }
  validates :details, presence: true, length: { maximum: 1000 }
  validates :due_date, presence: true,
                       format: { with: /\A\d{4}-\d{2}-\d{2}\Z/, message: 'Date must be in the format yyyy-mm-dd' }
  # ^ validare mai specifica pe date(31 zile, 12 luni, an>=an curent)

  belongs_to :column
  belongs_to :board
  belongs_to :user, optional: true
  has_many :comments, dependent: :delete_all

  DEPLOYED_COLUMN = 4

  def api_attributes
    {
      id:,
      title:,
      details:,
      due_date:,
      status: column.name,
      board: board_id,
      user: user_id
    }
  end
end
