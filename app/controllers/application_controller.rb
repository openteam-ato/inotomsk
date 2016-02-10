require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  rescue_from ActionView::MissingTemplate do |exception|
    raise ActionController::RoutingError.new('Not Found')
  end if Rails.env.production?

  layout :resolve_layout

  def resolve_layout
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      manage_permissions_path
    else
      workplace_root_path
    end
  end
end
