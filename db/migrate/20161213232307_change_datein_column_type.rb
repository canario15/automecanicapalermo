class ChangeDateinColumnType < ActiveRecord::Migration
  def change
    remove_column :work_orders, :date_in, :date
    add_column :work_orders, :date_in, :datetime
  end
end
