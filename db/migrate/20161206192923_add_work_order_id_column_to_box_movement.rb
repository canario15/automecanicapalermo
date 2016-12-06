class AddWorkOrderIdColumnToBoxMovement < ActiveRecord::Migration
  def change
    add_column :box_movements, :work_order_id, :integer
  end
end
