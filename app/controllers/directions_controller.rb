class DirectionsController < MainController
  def show
    @map_layer = MapLayer.find(params[:slug])

    @placemarks = placemarks
  end

  private
  def placemarks
    return (@map_layer.children.flat_map(&:placemarks) + @map_layer.placemarks) unless params[:map_layer]

    map_layer = MapLayer.find(params[:map_layer])
    placemarks = if map_layer.is_root?
                   map_layer.children.flat_map(&:placemarks) + map_layer.placemarks
                 else
                   map_layer.placemarks
                 end
    placemarks
  end
end
