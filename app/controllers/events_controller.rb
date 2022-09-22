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

  def display_date(given_event = event)
    start_date = given_event.start_date
    end_date = given_event.end_date
    get_date(start_date, end_date)
  end
  helper_method :display_date

  private

  def get_date(start_date, end_date)
    if end_date.nil?
      return start_date.strftime('%B %d at %H:%M').to_s if this_year?(start_date)

      return start_date.strftime('%B %d %Y at %H:%M').to_s
    end
    return "#{start_date.strftime('%B %d, %H:%M')}-#{end_date.strftime('%H:%M')}" if same_day?(start_date, end_date)
    return "#{start_date.strftime('%B %d, %H:%M')} - #{end_date.strftime('%H:%M')}" if same_day?(start_date, end_date)
    return "#{start_date.strftime('%B %d, %H:%M')} - #{end_date.strftime('%B %d, %H:%M')}" if same_month?(start_date,
                                                                                                          end_date)
    return "#{start_date.strftime('%B %d, %H:%M')} - #{end_date.strftime('%B %d, %H:%M')}" if this_year?(start_date)

    "#{start_date.strftime('%B %d %Y, %H:%M')} - #{end_date.strftime('%B %d %Y, %H:%M')}"
  end

  def same_year?(start_date, end_date)
    start_date.year == end_date.year
  end

  def this_year?(start_date)
    start_date.year == DateTime.now.year
  end

  def same_month?(start_date, end_date)
    return false unless same_year?(start_date, end_date)

    start_date.month == end_date.month
  end

  def same_day?(start_date, end_date)
    return false unless same_month?(start_date, end_date)

    start_date.day == end_date.day
  end

  def same_hour?(start_date, end_date)
    return false unless same_day?(start_date, end_date)

    start_date.hour == end_date.hour
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_date, :end_date, :user_id)
  end

  def event
    @event ||= Event.find(params[:id])
  end
end
