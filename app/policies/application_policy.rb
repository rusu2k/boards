# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record

  end

  # INTERN CONVENTION FOR ACCESS CONTROLS
  # ACTION'S NAME IS SET IN FORMAT:   <METHOD NAME>_<MODEL NAME>

  def index?
    action_name = "#{__method__[0..-2]}_#{self.class.name[0..-7]}"
    has_access?(action_name) #&& has_subscription?
  end

  def show?
    action_name = "#{__method__[0..-2]}_#{self.class.name[0..-7]}"
    has_access?(action_name) #&& has_subscription?
  end

  def create?
    action_name = "#{__method__[0..-2]}_#{self.class.name[0..-7]}"
    has_access?(action_name) #&& has_subscription?
  end

  def new?
    action_name = "#{__method__[0..-2]}_#{self.class.name[0..-7]}"
    has_access?(action_name)
  end

  def update?
    action_name = "#{__method__[0..-2]}_#{self.class.name[0..-7]}"
    has_access?(action_name) #&& has_subscription?
  end

  def edit?
    action_name = "#{__method__[0..-2]}_#{self.class.name[0..-7]}"
    has_access?(action_name)
  end

  def destroy?
    action_name = "#{__method__[0..-2]}_#{self.class.name[0..-7]}"
    has_access?(action_name) #&& has_subscription?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end

  private

  def has_access?(action)
    puts action
    action_id = Action.find_by(name: action).id

    role_ids = @user.roles.map { |role| role.id }
    role_ids.each do |role_id|
      return true if AccessControl.exists?(action_id: action_id, role_id: role_id)
    end
    false
  end


  def has_subscription?
    user_id = @user.id
    # first condition - for Boards Index/Create methods - no board_id
    return true if BoardSubscription.exists?(user_id: user_id, board_id: @board_id) || @board_id.blank?
    false
  end

end
