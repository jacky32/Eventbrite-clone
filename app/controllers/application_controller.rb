class ApplicationController < ActionController::Base
  def active_filter_class(filter)
    if params[:filter] == filter
      'is-active'
    else
      ''
    end
  end
  helper_method :active_filter_class

  def select_events(base = Event.all)
    params[:filter] ||= 'all'
    @current_filter = params[:filter]
    @selected_events = base if @current_filter == 'all'
    @selected_events = base.happening if @current_filter == 'happening'
    @selected_events = base.upcoming if @current_filter == 'upcoming'
    @selected_events = base.past if @current_filter == 'past'
  end
end
