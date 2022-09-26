class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @current_datetime = DateTime.current
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    event
    @attendees = event.attendees
  end

  def toggle_attendee; end

  def add_attendee
    @event = Event.find(params[:event_id])
    @event.attendees << current_user

    redirect_to event_path(@event)
  end

  def remove_attendee
    @event = Event.find(params[:event_id])
    @event.attendees.delete(current_user)

    redirect_to event_path(@event)
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_date, :end_date, :organiser_id)
  end

  def event
    @event ||= Event.find(params[:id])
  end
end
