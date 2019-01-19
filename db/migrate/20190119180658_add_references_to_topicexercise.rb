class AddReferencesToTopicexercise < ActiveRecord::Migration[5.2]
  def change
    add_reference :topicexercises, :topic, foreign_key: true
    add_reference :topicexercises, :exercise, foreign_key: true
  end
end
