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

  def display_date
    # same date
    if event.start_date == event.end_date
      event.start_date.to_fs(:long)
    # different date
    else
      "#{event.start_date.to_fs(:long)} - #{event.end_date.to_fs(:long)}"
    end
  end
  helper_method :display_date

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_date, :end_date)
  end

  def event
    @event ||= Event.find(params[:id])
  end
end
