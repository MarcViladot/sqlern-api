class RemoveUsernameFromUser < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :username
  	add_column :users, :password_digest, :string
  end
end
