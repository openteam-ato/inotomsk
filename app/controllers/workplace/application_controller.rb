class Workplace::ApplicationController < ApplicationController
  before_action :authenticate_user!

  layout 'devise'

  respond_to :html

  rescue_from CanCan::AccessDenied do
    redirect_to root_path
  end
end
