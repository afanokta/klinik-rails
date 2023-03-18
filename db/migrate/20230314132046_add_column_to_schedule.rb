class AddColumnToSchedule < ActiveRecord::Migration[7.0]
  def change
    add_column :schedules, :day, :integer
    add_column :schedules, :start_time, :time
    add_column :schedules, :end_time, :time

  end
end
