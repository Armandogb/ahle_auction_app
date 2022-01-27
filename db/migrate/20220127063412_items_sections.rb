class ItemsSections < ActiveRecord::Migration[5.2]
  def change
    create_table :items_sections do |t|
      t.integer :item_id
      t.integer :section_id
    end
  end
end
