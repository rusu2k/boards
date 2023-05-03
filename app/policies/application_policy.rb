# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # INTERN CONVENTION FOR ACCESS CONTROLS
  # ACTION'S NAME IS SET IN FORMAT:   <METHOD NAME>_<MODEL NAME>
  def method_missing(m, *args, **args, &block)
    action_name = "#{m.to_s.gsub("?","")}_#{self.class.name.underscore.gsub("_policy", "")}" # un snakeCase
    #puts has_access?(action_name)
    has_access?(action_name)
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    
  end

  private

  def has_access?(action)
    return false if action.blank?

    action_id = Action.find_by(name: action)&.id
    return false if action_id.blank?
    
    @user.roles.each do |role|
      return true if AccessControl.exists?(action_id: action_id, role_id: role.id)
    end
    false
  end


end
