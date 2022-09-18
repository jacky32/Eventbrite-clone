class AddEventEndDateToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :end_date, :date
    rename_column :events, :date, :start_date
  end
end
