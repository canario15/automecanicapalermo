class CreateWorkIns < ActiveRecord::Migration
  def change
    create_table :work_ins do |t|
      t.belongs_to :work_order, index: true, foreign_key: true
      t.string :work
      t.boolean :done
    end
  end
end
