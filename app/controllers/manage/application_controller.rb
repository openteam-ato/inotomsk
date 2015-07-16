class Manage::ApplicationController < ApplicationController
  sso_authenticate_and_authorize
  load_and_authorize_resource

  layout 'manage'
end
