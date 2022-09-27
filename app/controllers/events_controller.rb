class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    params[:filter] ||= 'all'
    @current_filter = params[:filter]
    @events = Event.all if @current_filter == 'all'
    @events = Event.happening if @current_filter == 'happening'
    @events = Event.upcoming if @current_filter == 'upcoming'
    @events = Event.past if @current_filter == 'past'
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.organiser = current_user

    if @event.save
      redirect_to event_path(@event)
      @event.attendees << current_user
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
