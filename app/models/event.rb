class Event < ApplicationRecord
  # has_many :attendees, foreign_key: 'attendee_id', class_name: 'User'
  # belongs_to :organizer, class_name: 'User'
  belongs_to :organiser, class_name: 'User', foreign_key: 'user_id'
  validates :name, :start_date, :end_date, :description, presence: true
end
