class Comment < ApplicationRecord
  #add validations
  validates :content, presence: true, length: { minimum: 2, maximum: 1000 }
  validates :user_id, presence: true

  belongs_to :story
  belongs_to :user
end
