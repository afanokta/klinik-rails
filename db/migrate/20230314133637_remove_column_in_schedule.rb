class RemoveColumnInSchedule < ActiveRecord::Migration[7.0]
  def change
    remove_column :schedules, :users_id
  end
end
