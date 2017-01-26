class AddColumnMatches < ActiveRecord::Migration[5.0]
  def change
  	add_column :matches, :p1lives, :integer, default: 5
  	add_column :matches, :p2lives, :integer, default: 5
  end
end
