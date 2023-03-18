class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string   :username
      t.string   :email
      t.string   :password_digest
      t.string   :name
      t.datetime :dob
      t.integer  :gender
      t.string   :phone_number
      t.integer  :role
      t.integer  :department_id, null: true

      t.timestamps
    end
  end
end
