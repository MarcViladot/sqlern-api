class Exercise < ApplicationRecord

  has_many :topicexercises
  has_many :topics, through: :topicexercises
  belongs_to :user
  has_many :comments
  belongs_to :conceptualmodel
  has_many :answeredexercises

end
