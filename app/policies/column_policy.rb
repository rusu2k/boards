class ColumnPolicy < ApplicationPolicy
    def permitted_attributes
        [:title, :position]
    end
end