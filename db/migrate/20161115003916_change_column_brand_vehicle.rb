class ChangeColumnBrandVehicle < ActiveRecord::Migration
  def change
    remove_column :vehicles, :brand
    add_column :vehicles, :car_brand_id, :integer
  end
end
