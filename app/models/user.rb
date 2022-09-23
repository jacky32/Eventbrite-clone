class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :event_attendings, foreign_key: :event_attendee_id
  has_many :attended_events, through: :event_attendings
  has_many :organised_events, class_name: 'Event', dependent: :destroy

  ROLES = %w[attendee organiser]
end
