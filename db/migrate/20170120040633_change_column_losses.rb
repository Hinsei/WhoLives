class ChangeColumnLosses < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :losses, :integer, default: 0
  end
end
