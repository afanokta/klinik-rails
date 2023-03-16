class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      

      t.timestamps
    end
    add_reference :schedules, :user, index: true
  end
end
