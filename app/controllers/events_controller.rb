class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    @events = @couple.events || []
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end

  def show
    return redirect_to events_path unless @event.user == current_user

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
    if @event.is_memory == true
      if @event.save
        redirect_to timeline_events_path, notice: "Memory forged!"
      else
        render :add_memory, status: :unprocessable_entity
      end
    elsif @event.save
      redirect_to @event, notice: 'Event saved to Calendar'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      return redirect_to timeline_events_path, notice: 'Memory updated' if event_params[:is_memory] == "1"

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
    @events = @couple.events.where(is_memory: true).order(:date)
  end

  def add_memory
    @event = Event.new
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :date, :details, :location, :is_memory, :image)
  end
end
