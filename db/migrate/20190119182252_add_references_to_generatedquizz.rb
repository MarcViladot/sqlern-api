class AddReferencesToGeneratedquizz < ActiveRecord::Migration[5.2]
  def change
    add_reference :generatedquizzs, :user, foreign_key: true
    add_reference :generatedquizzs, :quizz, foreign_key: true
  end
end
