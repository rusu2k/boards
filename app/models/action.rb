class Action < ApplicationRecord
    has_many :access_controls, :dependent => :delete_all 
    has_many :roles, through: :access_controls
end
