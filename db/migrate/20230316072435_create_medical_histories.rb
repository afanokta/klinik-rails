class CreateMedicalHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_histories do |t|
      t.string  :complaint
      t.string  :diagnosis
      t.string  :prescription
      t.integer :appointment_id

      t.timestamps
    end
  end
end
