class CreateDepartements < ActiveRecord::Migration[7.0]
  def change
    create_table :departements do |t|
      t.integer :id 
      t.string :name 


      t.timestamps
    end
  end
end
