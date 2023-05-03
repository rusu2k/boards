class Comment < ApplicationRecord
  #add validations
  # change data type content -> text !!!
  validates :content, presence: true, length: { minimum: 10, maximum: 500 }
  validates :user_id, presence: true

  belongs_to :story
  belongs_to :user
end
