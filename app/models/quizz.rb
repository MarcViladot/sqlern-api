class Quizz < ApplicationRecord
  belongs_to :user
  has_many :quizzexercises
  has_many :exercises, through: :quizzexercises
  has_many :generatedquizzs
  has_many :users, through: :generatedquizzs

  has_many :topicquizzs
  has_many :topics, through: :topicquizzs

end
