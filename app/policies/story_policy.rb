class StoryPolicy < ApplicationPolicy
    def permitted_attributes
        [:title, :details, :due_date]
    end

    def permitted_attributes_for_assign
        [:user_id]
    end

    def index?
        return false unless has_subscription?

        super
    end

    def show?
        super && has_subscription?
    end

    def create?
        super && has_subscription?
    end

    def update?
        super && has_subscription?
    end

    def destroy?
        super && has_subscription?
    end

    def next_column?
        super && has_story? && has_subscription?
    end

    def previous_column?
        super && has_story? && has_subscription?
    end

    private



    # checks if the story is assigned to the user
    def has_story?
        @record.user_id == @user.id
    end

    def has_subscription?
        if @record.is_a?(Board)
            board_id = @record.id
        else
            board_id = @record.board_id
        end

        return true if BoardSubscription.exists?(user_id: @user.id, board_id: board_id)
        false
    end
end