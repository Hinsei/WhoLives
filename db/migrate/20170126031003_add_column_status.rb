class AddColumnStatus < ActiveRecord::Migration[5.0]
  def change
  	add_column :matches, :status, :integer, default: 0
  end
end
