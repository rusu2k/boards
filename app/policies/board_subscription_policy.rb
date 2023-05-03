class BoardSubscriptionPolicy < ApplicationPolicy
    def permitted_attributes
        [:user_id]
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
        super && has_subscription?
      end
    
      def destroy?
        super && has_subscription?
      end
    
    
      private
    
      def has_subscription?
          if @record.is_a?(Board)
              board_id = @record.id
          else
              board_id = Board.find_by(id: @record.story_id).id
          end
    
          return true if BoardSubscription.exists?(user_id: @user.id, board_id: board_id)
          false
      end
end