class AddUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :encrypted_password, :string
  end
end
