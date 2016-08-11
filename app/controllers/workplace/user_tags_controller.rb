module Workplace
  class UserTagsController < Workplace::ApplicationController
    authorize_resource

    before_action :find_user, only: [:show, :update]

    def index
      @users = User.all
    end

    def update
      @user.user_tags.where(tag: @user.user_tags.pluck(:tag) - params[:user][:tags]).map(&:destroy)
      @user.user_map_layers.where(map_layer: @user.user_map_layers.pluck(:map_layer) - params[:user][:user_map_layers]).map(&:destroy)

      params[:user][:tags].each do |tag|
        @user.user_tags.create tag: tag
      end

      params[:user][:user_map_layers].each do |map_layer|
        @user.user_map_layers.create map_layer: map_layer
      end

      redirect_to workplace_user_tag_path(@user)
    end

    private

    def find_user
      @user = User.find(params[:id])
    end
  end
end
