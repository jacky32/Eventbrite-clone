class Event < ApplicationRecord
  def display_date
    # same date
    if start_date == end_date
      start_date.to_fs(:long)
    # different date
    else
      "#{start_date.to_fs(:long)} - #{end_date.to_fs(:long)}"
    end
  end
end
