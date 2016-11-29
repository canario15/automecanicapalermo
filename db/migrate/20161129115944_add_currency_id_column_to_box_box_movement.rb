class AddCurrencyIdColumnToBoxBoxMovement < ActiveRecord::Migration
  def change
    add_column :box_movements, :currency_id, :integer
  end
end
