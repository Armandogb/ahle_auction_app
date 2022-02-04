class UpdateUserFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :name
    remove_column :users, :cn
    remove_column :users, :cm
    remove_column :users, :cy
    remove_column :users, :cp
    remove_column :users, :cz
    remove_column :users, :ct

    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string, limit: 10
  end
end
