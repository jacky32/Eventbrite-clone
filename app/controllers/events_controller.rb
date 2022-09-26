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

  def edit
    redirect_to event unless organiser? # TODO: Add flash
    event
  end

  def update
    event
    if event.update(event_params)
      redirect_to event
    else
      render :edit, status: :unprocessable_entity
    end
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

  def attends?(user = current_user)
    event.attendees.exists?(user.id)
  end
  helper_method :attends?

  def organiser?(user = current_user)
    event.organiser == user
  end
  helper_method :organiser?

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_date, :end_date, :organiser_id)
  end

  def event
    @event ||= Event.find(params[:id])
  end
end
