class AddSectiontoAuction < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :auction_id, :integer
  end
end
