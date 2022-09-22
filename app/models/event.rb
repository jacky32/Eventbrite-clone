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
end
