class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :application do
      user.permissions.any?
    end

    can :manage, :all if user.admin?
    can :manage, [MapLayer, Placemark] if user.map_manager?

  end
end
