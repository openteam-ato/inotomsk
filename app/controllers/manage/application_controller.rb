class Manage::ApplicationController < ApplicationController
  before_filter :authenticate_user!, :set_locale
  load_and_authorize_resource

  layout 'manage'

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url
  end

  def set_locale
    I18n.locale = :ru
  end
end
