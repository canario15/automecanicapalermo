class AddCurrencyColumnToReplacements < ActiveRecord::Migration
  def change
    add_column :replacements, :currency, :string
  end
end
