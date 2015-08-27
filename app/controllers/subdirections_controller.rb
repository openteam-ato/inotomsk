class SubdirectionsController < MainController
  def show
    @map_layer = MapLayer.find(params[:slug]) rescue nil

    @placemarks = MapLayer.find(params[:slug]).placemarks rescue nil
  end
end
