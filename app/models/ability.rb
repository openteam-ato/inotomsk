class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, Permission if user.manager?
  end
end