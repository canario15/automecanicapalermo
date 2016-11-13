class AddStatusColumnToWorkOrder < ActiveRecord::Migration
  def change
    add_column :work_orders, :status, :string
  end
end
