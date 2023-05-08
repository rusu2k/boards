class Role < ApplicationRecord
  has_many :access_controls, dependent: :delete_all
  has_many :actions, through: :access_controls

  has_many :user_roles, dependent: :delete_all
  has_many :users, through: :user_roles
end
