class RoadMapController < MainController
  def index
    @entries = Event.all.group_by(&:state).sort
  end
end
