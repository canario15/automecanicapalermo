class AddColumnPriceToWorkDones < ActiveRecord::Migration
  def change
    add_column :work_dones, :price, :string
  end
end
