class AddColumnsToTopicquizz < ActiveRecord::Migration[5.2]
  def change
    add_reference :topicquizzs, :topic, foreign_key: true
    add_reference :topicquizzs, :quizz, foreign_key: true
  end
end
