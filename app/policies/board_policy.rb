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

    def create?
        super 
    end

    def update?
        super
    end

    def destroy?
        super
    end



    private

    def has_subscription?

        if @record.is_a?(Board)
            return true if BoardSubscription.exists?(user_id: @user.id, board_id: @record.id)
        else
            return true
        end
        false
    end
end