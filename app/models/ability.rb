class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :application do
      user.permissions.any?
    end

    can [:edit, :update], User do |u|
      user == u
    end

    can [:new, :create], User if user.inviter?

    can :manage, :all if user.admin?
    can :manage, [MapLayer, Placemark, Event] if user.map_manager?
  end
end
