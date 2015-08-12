class DirectionsController < MainController
  def show
    map_layer = MapLayer.find(params[:slug])
    @placemarks = map_layer.children.flat_map(&:placemarks)

    @events = map_layer.events.send(locale)

    @events = @events.send(params[:state]) if params[:state]

    map_layer.children.each do |child|
      @events += child.events.send(locale) unless params[:state]

      @events += child.events.send(locale).send(params[:state]) if params[:state]
    end

    @entries = @events.group_by(&:state).sort
  end
end
