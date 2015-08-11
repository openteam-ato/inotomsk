class RoadMapController < MainController
  def index
    @entries = events.group_by(&:state).sort
  end

  private

  def events
    return Event.send(locale) unless params[:state]
    Event.send(locale).send(params[:state])
  end
end
