class AddColumnRecivedAndEntregaToWorkOrder < ActiveRecord::Migration
  def change
    add_column :work_orders, :received_by_id, :integer
    add_column :work_orders, :delivered_by_id, :integer
    add_column :work_orders, :worked_by_id, :integer
  end
end
