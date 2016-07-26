class SubdirectionsController < MainController
  def show
    @map_layer = begin
                   MapLayer.find(params[:slug])
                 rescue
                   nil
                 end

    @placemarks = begin
                    MapLayer.find(params[:slug]).placemarks
                  rescue
                    nil
                  end
  end
end
