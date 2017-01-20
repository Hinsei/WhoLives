class ChangeUsersPasswordNullVersion2 < ActiveRecord::Migration[5.0]
  def change
  	change_column_null :users, :password_digest, :string, null: true
  end
end
