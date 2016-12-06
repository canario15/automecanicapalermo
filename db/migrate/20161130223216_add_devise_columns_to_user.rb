class AddDeviseColumnsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :password, :null => false, :default => '', :limit => 128
    end
  end
end
