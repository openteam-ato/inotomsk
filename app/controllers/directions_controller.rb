class DirectionsController < MainController
  def show
    @placemarks = MapLayer.find(params[:slug]).placemarks
  end
end
