class AddColumnSubtotalRepToBudget < ActiveRecord::Migration
  def change
    add_column :budgets, :subtotal_rep, :integer
    add_column :budgets, :subtotal_work_does, :integer
  end
end
