class AddIndexesToTables < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :mail, unique: true
    add_index :users, :address1
    add_index :users, :birthday
  end
end
