class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.date :date
      t.integer :status
      t.integer :schedule_id
      t.integer :patient_id

      t.timestamps
    end
  end
end
