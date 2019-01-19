class CreateJoinanswereds < ActiveRecord::Migration[5.2]
  def change
    create_table :joinanswereds do |t|
      t.references :answeredexercise, foreign_key: true
      t.references :answeredquizz, foreign_key: true

      t.timestamps
    end
  end
end
