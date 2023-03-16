class AddColumnToSchedule < ActiveRecord::Migration[7.0]
  def change
    add_column :schedules, :day, :date
    add_column :schedules, :start_time, :datetime 
    add_column :schedules, :end_time, :datetime 
    
  end
end
