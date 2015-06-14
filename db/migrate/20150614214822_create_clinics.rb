class CreateClinics < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone
      t.string :fax
      t.decimal :lat
      t.decimal :lng

      t.timestamps null: false
    end
  end
end
