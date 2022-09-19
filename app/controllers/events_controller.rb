class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    event
  end

  def display_date(given_event = event)
    # same date
    if given_event.start_date == given_event.end_date
      given_event.start_date.to_fs(:long)
    # different date
    else
      "#{given_event.start_date.to_fs(:long)} - #{given_event.end_date.to_fs(:long)}"
    end
  end
  helper_method :display_date

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_date, :end_date, :user_id)
  end

  def event
    @event ||= Event.find(params[:id])
  end
end
