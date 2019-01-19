class CreateAnsweredexercises < ActiveRecord::Migration[5.2]
  def change
    create_table :answeredexercises do |t|
      t.text :answered
      t.boolean :correct
      t.references :exercise, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
