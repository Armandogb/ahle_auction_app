class AuctionsSections < ActiveRecord::Migration[5.2]
  def change
    create_table :auctions_sections do |t|
      t.integer :auction_id
      t.integer :section_id
    end
  end
end
