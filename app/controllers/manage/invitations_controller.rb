class Manage::InvitationsController <  Devise::InvitationsController
  helper_method :available_scopes
  load_and_authorize_resource :class => "User"
  layout "manage", only: [:index, :new]


  def new
    super
  end

  def create
    super
    resource.permissions.create(role: "workplace_user")
  end

  def index
    @invited_users = scoped_invitation
  end

  private

  def scoped_invitation
    return User.send(params[:scope]) if available_scopes.include?(params[:scope])
    User.created_by_invite
  end

  def available_scopes
    %w(created_by_invite invitation_accepted  invitation_not_accepted)
  end

  private

    def after_invite_path_for(resource)
      manage_invitations_path
    end

end
