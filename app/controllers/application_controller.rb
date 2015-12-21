class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout

  def layout
    if devise_controller?
      I18n.locale = :ru
      "manage"
    else
      "application"
    end
  end
end
