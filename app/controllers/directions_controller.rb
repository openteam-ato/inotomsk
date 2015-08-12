class DirectionsController < MainController
  def show
    @placemarks = MapLayer.find(params[:slug]).children.flat_map(&:placemarks)
  end
end
