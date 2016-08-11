module Workplace
  class UserTagsController < Workplace::ApplicationController
    authorize_resource

    before_action :find_user, only: [:show, :update]

    def index
      @users = User.all
    end

    def update
      @user.user_tags.where(tag: @user.user_tags.pluck(:tag) - params[:user][:tags]).map(&:destroy)

      params[:user][:tags].each do |tag|
        @user.user_tags.create tag: tag
      end

      redirect_to workplace_user_tag_path(@user)
    end

    private

    def find_user
      @user = User.find(params[:id])
    end
  end
end
