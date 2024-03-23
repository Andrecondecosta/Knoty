class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    @events = Event.all || []
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end

  def show
    @day_events = Event.where(date: @event.date)
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.couple = @couple
    @event.user = current_user
    if @event.save
      if @event.is_memory
        redirect_to timeline_events_path
      else
        redirect_to @event
      end
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path, notice: 'Event was successfully update.'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    if params[:origin] == 'timeline'
      redirect_to timeline_events_path
    else
      redirect_to events_path
    end
  end

  def timeline
    @events = Event.where(is_memory: true).to_a
    @events << Event.new(date: current_user.created_at, name: "Welcome!", details: "The start of an", location: "Amazing adventure!")
    @events.sort_by! { |event| -event.date.to_time.to_i }
  end

  def add_memory
    @event = Event.new
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :date, :details, :location, :is_memory)
  end
end
