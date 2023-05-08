class BoardPolicy < ApplicationPolicy
  def permitted_attributes
    [:title]
  end

  def index?
    super && has_subscription?
  end

  def show?
    super && has_subscription?
  end

  private

  def has_subscription?
    return true unless @record.is_a?(Board)
    return true if BoardSubscription.exists?(user_id: @user.id, board_id: @record.id)

    false
  end
end
