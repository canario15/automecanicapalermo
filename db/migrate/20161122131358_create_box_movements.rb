class CreateBoxMovements < ActiveRecord::Migration
  def change
    create_table :box_movements do |t|
      t.datetime :date
      t.string :cost_center
      t.string :desc
      t.integer :value
      t.string :box_movement_type
      t.integer :user_id
    end
  end
end
