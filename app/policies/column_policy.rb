class ColumnPolicy < ApplicationPolicy
  def permitted_attributes
    %i[title position]
  end
end
