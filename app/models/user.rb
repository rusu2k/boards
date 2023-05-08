class User < ApplicationRecord
  has_many :board_subscriptions
  has_many :boards, through: :board_subscriptions
  has_many :stories

  has_many :user_roles, dependent: :delete_all
  has_many :roles, through: :user_roles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
