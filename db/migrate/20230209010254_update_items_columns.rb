class UpdateItemsColumns < ActiveRecord::Migration[5.2]
  def change
      change_column :items, :name, :string, null: true, default: nil
      change_column :items, :description, :string, null: true, default: nil
      change_column :items, :photo, :string, null: true, default: nil
  end
end
