class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.text :statement
      t.text :solution
      t.boolean :public

      t.timestamps
    end
  end
end
