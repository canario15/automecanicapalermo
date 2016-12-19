class CreateIvas < ActiveRecord::Migration
  def change
    create_table :ivas do |t|
      t.integer :value
    end
  end
end
