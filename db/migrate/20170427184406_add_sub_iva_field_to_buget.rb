class AddSubIvaFieldToBuget < ActiveRecord::Migration
  def change
    add_column :budgets, :iva, :integer
    add_column :budgets, :iva_dol, :integer
  end
end
