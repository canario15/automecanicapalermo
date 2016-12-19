class AddSubtotalWorkDoesDolColumnToBudget < ActiveRecord::Migration
  def change
    add_column :budgets, :subtotal_work_does_dol, :integer
  end
end
