class CreateAuctions < ActiveRecord::Migration[5.2]
  def change
    create_table :auctions do |t|
      t.string :name, null: false, default: ""
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
