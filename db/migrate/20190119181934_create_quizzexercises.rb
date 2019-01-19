class CreateQuizzexercises < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzexercises do |t|
      t.references :exercise, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
