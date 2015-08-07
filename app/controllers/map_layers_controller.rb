class MapLayersController < MainController
  def index
    @map_layers = MapLayer.roots
    @placemarks = placemarks.group_by(&:map_layer_title)
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
