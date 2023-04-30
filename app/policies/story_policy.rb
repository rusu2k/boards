class StoryPolicy < ApplicationPolicy

    def assign
        action_name = "#{__method__}_#{self.class.name[0..-7]}"
        has_access?(action_name) #&& has_subscription?
    end

    def advance
        action_name = "#{__method__}_#{self.class.name[0..-7]}"
        has_access?(action_name) #&& has_subscription? && has_story?
    end

    def revert
        action_name = "#{__method__}_#{self.class.name[0..-7]}"
        has_access?(action_name) #&& has_subscription? && has_story?
    end

    private

    def has_story?
        @record.user_id == @user.id
    end
end