class Ability
  include CanCan::Ability

  def initialize(user)
    can [:edit, :update], User if user.nil?

    return unless user

    can [:index, :new, :create], User if user.inviter?

    can [:edit, :update], User do |u|
      user == u
    end

    can :manage, [MapLayer, Placemark, Event] if user.map_manager?

    can :read, [Document, RelatedDocument] if user.workplace_user?

    can :manage, [Document, RelatedDocument] if user.documents_manager?

    can :manage, :all if user.admin?
  end
end
