class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :owner
      t.string :invoice_name
      t.string :rut
      t.string :phone
      t.string :address
      t.string :email
    end
  end
end
