class Manage::ApplicationController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  layout 'manage'

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path
  end
end
