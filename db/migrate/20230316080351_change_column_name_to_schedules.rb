class ChangeColumnNameToSchedules < ActiveRecord::Migration[7.0]
  def change
    rename_column :schedules, :user_id, :doctor_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
