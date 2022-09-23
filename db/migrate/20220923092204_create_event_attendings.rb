class CreateEventAttendings < ActiveRecord::Migration[7.0]
  def change
    create_table :event_attendings do |t|
      t.belongs_to :attended_events
      t.belongs_to :event_attendees
      t.timestamps
    end
  end
end
