class AddSectionItemRelationship < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :section_id, :integer
  end
end
