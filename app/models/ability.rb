class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :all

    #can :manage, :application do
      #user.permissions.any?
    #end

    #can :manage, :permissions do
      #user.manager?
    #end
  end
end
