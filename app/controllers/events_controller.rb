class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_couple, only: [:create, :update]

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
      redirect_to events_path, notice: 'Event was successfully create.'
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
    redirect_to events_url, notice: 'Event was successfully deleted.'
  end
  private

    def set_event
      @event = Event.find(params[:id])
    end


    def event_params
      params.require(:event).permit(:name, :date, :details)
    end

    def set_couple
      return unless signed_in?

      @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    end

  end
