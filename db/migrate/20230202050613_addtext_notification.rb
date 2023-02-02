class AddtextNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :text_alerts, :jsonb, null: false, default: {}
  end
end
