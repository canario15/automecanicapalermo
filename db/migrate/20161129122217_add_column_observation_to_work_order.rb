class AddColumnObservationToWorkOrder < ActiveRecord::Migration
  def change
    add_column :work_orders, :observation, :text
  end
end
