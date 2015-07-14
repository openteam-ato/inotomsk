class Manage::MapLayersController < Manage::ApplicationController
  def index
    @map_layers = MapLayer.all
  end

  def new
    add_breadcrumb "Карта", manage_map_layers_path
    add_breadcrumb "Новый слой", new_manage_map_layer_path

    @map_layer = MapLayer.new
  end

  def create
    @map_layer = MapLayer.new(params[:map_layer])

    add_breadcrumb "Карта", manage_map_layers_path
    add_breadcrumb "Новый слой", new_manage_map_layer_path

    if @map_layer.save
      redirect_to manage_map_layers_path
    else
      render :new
    end
  end

  def edit
    @map_layer = MapLayer.find(params[:id])

    add_breadcrumb "Карта", manage_map_layers_path
    add_breadcrumb "Редактировать", edit_manage_map_layer_path(@map_layer)
  end

  def update
    @map_layer = MapLayer.find(params[:id])
    add_breadcrumb "Карта", manage_map_layers_path
    add_breadcrumb "Редактировать", edit_manage_map_layer_path(@map_layer)

    if @map_layer.update_attributes(params[:map_layer])
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
