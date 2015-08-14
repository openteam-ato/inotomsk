class SubdirectionsController < MainController
  def show
    @placemarks = MapLayer.find(params[:slug]).placemarks rescue nil
  end
end
