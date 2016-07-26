class Manage::MapLayersController < Manage::ApplicationController
  def index
    @map_layers = MapLayer.roots
    @placemarks = placemarks
  end

  def new
    add_breadcrumb 'Карта', manage_map_layers_path
    add_breadcrumb 'Новый слой', new_manage_map_layer_path

    @map_layer = MapLayer.new
  end

  def create
    add_breadcrumb 'Карта', manage_map_layers_path
    add_breadcrumb 'Новый слой', new_manage_map_layer_path

    @map_layer = MapLayer.new(params[:map_layer])

    if @map_layer.save
      redirect_to manage_map_layers_path
    else
      render :new
    end
  end

  def edit
    @map_layer = MapLayer.find(params[:id])

    add_breadcrumb 'Карта', manage_map_layers_path
    add_breadcrumb 'Редактировать', edit_manage_map_layer_path(@map_layer)
  end

  def update
    @map_layer = MapLayer.find(params[:id])
    add_breadcrumb 'Карта', manage_map_layers_path
    add_breadcrumb 'Редактировать', edit_manage_map_layer_path(@map_layer)

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

  private

  def placemarks
    return (@map_layers.flat_map(&:children).flat_map(&:placemarks) + @map_layers.flat_map(&:placemarks)) unless params[:map_layer]

    map_layer = MapLayer.find(params[:map_layer])
    placemarks = if map_layer.is_root?
                   map_layer.children.flat_map(&:placemarks) + map_layer.placemarks
                 else
                   map_layer.placemarks
                 end
    placemarks
  end
end
