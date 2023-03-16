class AddReferenceToSchedule < ActiveRecord::Migration[7.0]
  def change
    add_reference :schedules, :users, index: true
  end
end
