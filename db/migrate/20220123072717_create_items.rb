class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false, default: ""
      t.string :description, null: false, default: ""
      t.string :photo, null: false, default: nil
      t.integer :starting_bid, null: false, default: 0
      t.integer :min_bid, null: false, default: 0
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
