class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.integer :customer_id
      t.string :brand
      t.string :model
      t.string :displacement
      t.string :year
      t.string :plate
      t.string :color
      t.string :chassis_number

      t.timestamps null: false
    end
  end
end
