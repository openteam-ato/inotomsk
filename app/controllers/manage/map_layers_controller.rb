class Manage::MapLayersController < Manage::ApplicationController
  def index
    @map_layers = MapLayer.all
  end

  def new
    @map_layer = MapLayer.new
  end

  def create
    map_layer = MapLayer.new(params[:map_layer])
    if map_layer.save
      redirect_to manage_map_layers_path
    else
      render :new
    end
  end

  def show
    @map_layer = MapLayer.find(params[:id])
  end

  def edit
    @map_layer = MapLayer.find(params[:id])
  end

  def update
    map_layer = MapLayer.find(params[:id])
    if map_layer.update_attributes(params[:map_layer])
      redirect_to manage_map_layers_path
    else
      render :edit
    end
  end

  def destroy
    MapLayer.find(params[:id]).destroy
    redirect_to manage_map_layers_path
  end
end
