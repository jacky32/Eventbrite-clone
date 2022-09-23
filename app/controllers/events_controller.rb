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
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    event
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_date, :end_date, :user_id)
  end

  def event
    @event ||= Event.find(params[:id])
  end
end
