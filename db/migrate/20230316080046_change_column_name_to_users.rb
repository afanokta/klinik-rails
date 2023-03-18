class ChangeColumnNameToUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :department_id, :departement_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
