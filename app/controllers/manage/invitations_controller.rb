class Manage::InvitationsController <  Devise::InvitationsController
  def new
    super
    authorize! :new, resource
  end

  def create
    super
    resource.permissions.create(role: "workplace_user")
    authorize! :create, resource
  end
end
