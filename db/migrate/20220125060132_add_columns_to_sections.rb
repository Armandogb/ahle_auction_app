class AddColumnsToSections < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :title, :string
    add_column :sections, :display_name, :string
    add_column :sections, :end_time, :datetime
    add_column :sections, :active, :boolean, default: true
  end
end
