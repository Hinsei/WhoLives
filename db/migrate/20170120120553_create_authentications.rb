class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
    	t.string :uid
    	t.string :token
    	t.string :provider
    	t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
