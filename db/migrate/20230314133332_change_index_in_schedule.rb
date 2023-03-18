class ChangeIndexInSchedule < ActiveRecord::Migration[7.0]
  def change
    remove_index :schedules, name: :index_schedules_on_users_id
    # add_reference :schedules, :user, index: true
  end
end
