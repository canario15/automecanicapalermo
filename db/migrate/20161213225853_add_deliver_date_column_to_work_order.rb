class AddDeliverDateColumnToWorkOrder < ActiveRecord::Migration
  def change
    add_column :work_orders, :deliver_date, :datetime
  end
end
