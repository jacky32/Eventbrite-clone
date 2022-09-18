class AddEventEndDateToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :event_end_date, :date
    rename_column :events, :date, :event_start_date
  end
end
