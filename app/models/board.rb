class Board < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }, format: { with: /\A[a-zA-Z]/ }
  has_many :board_subscriptions, dependent: :delete_all
  has_many :users, through: :board_subscriptions
  has_many :stories, dependent: :delete_all
end
