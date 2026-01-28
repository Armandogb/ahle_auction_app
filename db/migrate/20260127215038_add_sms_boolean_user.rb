class AddSmsBooleanUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :receive_sms, :boolean, default: true
  end
end
