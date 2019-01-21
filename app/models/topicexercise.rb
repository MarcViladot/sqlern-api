class Topicexercise < ApplicationRecord

  belongs_to :exercise
  belongs_to :topicexercise

  validates_uniqueness_of :topic_id, scope: :exercise_id

end
