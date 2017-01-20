class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
    	t.string :email
    	t.string :username
    	t.string :password_digest
    	t.integer :wins
    	t.integer :losses
    	t.integer :total_game
    	t.integer :role, default: 0
      t.timestamps null: false
    end
  end
end
