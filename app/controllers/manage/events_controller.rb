class Manage::EventsController < Manage::ApplicationController
  def index
    @events = Event.all
  end

  def new
    add_breadcrumb "Список событий", manage_events_path
    add_breadcrumb "Новое событие", new_manage_event_path

    @event = Event.new
  end

  def create
    add_breadcrumb "Список событий", manage_events_path
    add_breadcrumb "Новое событие", new_manage_event_path

    @event = Event.new(params[:event])

    if @event.save
      redirect_to manage_events_path
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])

    add_breadcrumb "Список событий", manage_events_path
    add_breadcrumb "Редактировать событие", edit_manage_event_path(@event)
  end

  def update
    @event = Event.find(params[:id])

    add_breadcrumb "Список событий", manage_events_path
    add_breadcrumb "Редактировать событие", edit_manage_event_path(@event)

    if @event.update_attributes(params[:event])
      redirect_to manage_events_path
    else
      render :edit
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to manage_events_path
  end
end
