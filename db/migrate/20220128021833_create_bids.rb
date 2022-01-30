class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.integer :value, default: 0
      t.integer :user_id
      t.integer :item_id

      t.timestamps
    end
  end
end
