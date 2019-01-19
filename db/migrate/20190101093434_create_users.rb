class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :last_name
      t.string :username
      t.integer :role

      t.timestamps
    end
  end
end
