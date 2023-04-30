class ColumnPolicy < ApplicationPolicy
    def index?
        action_name = "#{__method__}_#{self.class.name[0..-7]}"
        has_access?(action_name)
      end
    
      def show?
        action_name = "#{__method__}_#{self.class.name[0..-7]}"
        has_access?(action_name)
      end
    
      def create?
        action_name = "#{__method__}_#{self.class.name[0..-7]}"
        has_access?(action_name)
      end
    
      def update?
        action_name = "#{__method__}_#{self.class.name[0..-7]}"
        has_access?(action_name)
      end
    
      def destroy?
        action_name = "#{__method__}_#{self.class.name[0..-7]}"
        has_access?(action_name)
      end
end