class CreateWorkDones < ActiveRecord::Migration
  def change
    create_table :work_dones do |t|
      t.belongs_to :work_order, index: true, foreign_key: true
      t.string :work

      t.timestamps null: false
    end
  end
end
