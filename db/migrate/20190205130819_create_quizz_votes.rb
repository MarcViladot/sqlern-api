class CreateQuizzVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizz_votes do |t|
      t.references :user, foreign_key: true
      t.references :quizz, foreign_key: true

      t.timestamps
    end
  end
end
