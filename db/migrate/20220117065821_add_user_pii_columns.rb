class AddUserPiiColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :cn, :string
    add_column :users, :cm, :string
    add_column :users, :cy, :string
    add_column :users, :cp, :string
    add_column :users, :cz, :string
    add_column :users, :ct, :string
  end
end
