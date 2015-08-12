class RoadMapController < MainController
  def index
    @events = events.page(params[:page]).per(15)
    @entries = @events.group_by(&:state).sort
  end

  private

  def events
    return Event.where(:map_layer_id => MapLayer.where(:slug => params[:filters]).flat_map(&:id)).send(locale) if params[:filters] && !params[:state]

    return Event.where(:map_layer_id => MapLayer.where(:slug => params[:filters]).flat_map(&:id)).send(locale).send(params[:state]) if params[:filters] && params[:state]

    return Event.send(locale) unless params[:state]

    Event.send(locale).send(params[:state])
  end
end
