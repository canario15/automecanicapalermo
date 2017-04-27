class AddSubTotalFieldToBuget < ActiveRecord::Migration
  def change
    add_column :budgets, :subtotal, :integer
    add_column :budgets, :subtotal_dol, :integer
  end
end
