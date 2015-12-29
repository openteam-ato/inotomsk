class Manage::ApplicationController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  layout 'manage'

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url
  end
end
