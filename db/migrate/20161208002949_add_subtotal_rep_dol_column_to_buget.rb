class AddSubtotalRepDolColumnToBuget < ActiveRecord::Migration
  def change
    add_column :budgets, :subtotal_rep_dol, :integer
    add_column :budgets, :total_dol, :integer
  end
end
