class AccessControl < ApplicationRecord
  belongs_to :role
  belongs_to :action
end
