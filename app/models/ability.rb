# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # for testing only - remove soon!
    # can :read, :all
    return if user.blank? # Guests have no permissions

    # A bee can manage (create, update, delete, read) its own hive
    can :manage, Hive, user_id: user.id

    # A bee can create flower patches
    # can :create, FlowerPatch

    # A bee can view all flower patches (they are public)
    # can :read, FlowerPatch
  end
end
