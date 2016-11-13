class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.belongs_to :work_order, index: true, foreign_key: true
      t.integer :total

      t.timestamps null: false
    end
  end
end
