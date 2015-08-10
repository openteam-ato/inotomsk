class RoadMapController < MainController
  def index
    @entries = events.group_by(&:state).sort
  end

  private

  def events
    return Event.all unless params[:state]
    Event.where(state: params[:state])
  end
end
