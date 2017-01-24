class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
    	t.string :category
    	t.string :word
    	t.integer :player_1
    	t.integer :player_2
    	t.timestamps null: false
    end
  end
end
