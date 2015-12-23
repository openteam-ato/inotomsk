class Manage::UsersController < Manage::ApplicationController
  #before_filter :set_locale

  layout 'devise'

  def edit
  end

  def update
    user = params[:user]
    user[:password].blank? && user[:password_confirmation].blank? ? [:password, :password_confirmation].each{|s| user.delete(s) } : nil

    unless current_user.valid_password?(user[:current_password])
      #по ряду причин выкинул валидацию из модели - нужна в одном action, заставляет придумывать многоэтажные костыли в остальных
      current_user.errors[:current_password] = "Неправильно указан текущий пароль"
      render :edit
    else
      if current_user.update_attributes(params[:user])
        flash[:success] = I18n.t("devise.registrations.updated")
        render :edit
      else
        render :edit
      end
    end
  end

  private
    def set_locale
      I18n.locale = :ru
    end
end
