class Event < ApplicationRecord
  # has_many :attendees, foreign_key: 'attendee_id', class_name: 'User'
  # belongs_to :organizer, class_name: 'User'
  belongs_to :organiser, class_name: 'User', foreign_key: 'user_id'
  validates :name, :start_date, :description, presence: true
  validate :start_date_cannot_be_equal_to_end_date, :must_be_longer_than_30_minutes

  def start_date_cannot_be_equal_to_end_date
    return if end_date.nil?

    errors.add(:end_date, 'cannot be same as start date') if start_date.end_of_minute == end_date.end_of_minute
  end

  def must_be_longer_than_30_minutes
    return if end_date.nil?

    if ((end_date.end_of_minute - start_date.end_of_minute) / 1.minutes) < 30
      errors.add(:end_date, 'must last longer than 30 minutes')
    end
  end

  def display_date
    get_date(start_date, end_date)
  end
  
  private

  def get_date(start_date, end_date)
    if end_date.nil?
      return start_date.strftime('%B %d at %H:%M').to_s if this_year?(start_date)

      return start_date.strftime('%B %d %Y at %H:%M').to_s
    end
    return "#{start_date.strftime('%B %d, %H:%M')}-#{end_date.strftime('%H:%M')}" if same_day?(start_date, end_date)
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


end
