class Manage::UsersController < Manage::ApplicationController

  def edit
  end

  def update
    if current_user.update_attributes(params[:user])
      flash[:success] = I18n.t("devise.registrations.updated")
      redirect_to manage_root_path
    else
      render :edit
    end
  end
end
