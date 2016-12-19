class AddCurrencyColumnToWorkDoes < ActiveRecord::Migration
  def change
    add_column :work_dones, :currency, :string
  end
end
