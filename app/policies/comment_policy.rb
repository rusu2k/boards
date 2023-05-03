class CommentPolicy < ApplicationPolicy
  def permitted_attributes
    [:content]
  end

  def index?
    super && has_subscription?
  end

  def show?
    super && has_subscription?
  end

  def create?
    super && has_subscription?
  end

  def update?
    super && has_subscription? && has_comment?
  end

  def destroy?
    super && has_subscription? && has_comment?
  end


  private

  def has_comment?
    @user.id == @record.user_id
  end

  def has_subscription?
      if @record.is_a?(Comment)
        board_id = Story.find_by(id: @record.story_id).board_id
      elsif @record.is_a?(Story)
        board_id = @record.board_id
      end

      return true if BoardSubscription.exists?(user_id: @user.id, board_id: board_id)
      false
  end
end