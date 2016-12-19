class AddDiscountColumnToBudget < ActiveRecord::Migration
  def change
    add_column :budgets, :discount, :integer
  end
end
