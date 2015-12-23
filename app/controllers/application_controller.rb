class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout

  def layout
    if devise_controller?
      I18n.locale = :ru
      "devise"
    else
      "application"
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
