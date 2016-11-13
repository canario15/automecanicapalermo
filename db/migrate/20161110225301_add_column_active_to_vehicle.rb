class AddColumnActiveToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :active, :boolean, :default => true
  end
end
