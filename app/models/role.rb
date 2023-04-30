class Role < ApplicationRecord
    has_many :access_controls
    has_many :actions, through: :access_controls

    has_many :user_roles
    has_many :users, through: :user_roles
    
end
