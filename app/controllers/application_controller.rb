class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout

  def layout
    if devise_controller?
      "manage"
    else
      "application"
    end
  end
end
