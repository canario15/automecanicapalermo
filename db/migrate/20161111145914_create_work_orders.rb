class CreateWorkOrders < ActiveRecord::Migration
  def change
    create_table :work_orders do |t|
      t.date :date_in
      t.integer :number
      t.belongs_to :customer, index: true, foreign_key: true
      t.belongs_to :vehicle, index: true, foreign_key: true
      t.string :km
      t.string :fuel
      t.text :coments
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
