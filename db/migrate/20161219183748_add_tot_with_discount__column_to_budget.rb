class AddTotWithDiscountColumnToBudget < ActiveRecord::Migration
  def change
    add_column :budgets, :total_budget_pay, :integer
    add_column :budgets, :total_budget_pay_dol, :integer
  end
end
