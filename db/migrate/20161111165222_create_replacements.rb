class CreateReplacements < ActiveRecord::Migration
  def change
    create_table :replacements do |t|
      t.string :name
      t.string :price
      t.belongs_to :work_order, index: true, foreign_key: true

    end
  end
end
