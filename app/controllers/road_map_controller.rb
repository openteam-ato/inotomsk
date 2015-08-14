class RoadMapController < MainController
  def index
    @events = events.page(params[:page]).per(10)
    @entries = @events.group_by(&:state).sort
  end

  private

  def events
    layer_ids = MapLayer.where(:slug => params[:filters]).map(&:id) + MapLayer.where(:slug => params[:filters]).flat_map(&:children).flat_map(&:id)

    return Event.where(:map_layer_id => layer_ids).send(locale) if params[:filters] && !params[:state]

    return Event.where(:map_layer_id => layer_ids).send(locale).send(params[:state]) if params[:filters] && params[:state]

    return Event.send(locale) unless params[:state]

    Event.send(locale).send(params[:state])
  end
end
