class AddQuizztoQuizzexercise < ActiveRecord::Migration[5.2]
  def change
    add_reference :quizzexercises, :quizz, foreign_key: true
  end
end
