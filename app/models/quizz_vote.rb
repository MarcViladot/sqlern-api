class QuizzVote < ApplicationRecord
  belongs_to :user
  belongs_to :quizz

  validates_uniqueness_of :user_id, scope: :quizz_id
end
