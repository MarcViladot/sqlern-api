class Topic < ApplicationRecord

  has_many :topicexercises
  has_many :exercises, through: :topicexercises

  has_many :topicquizzs
  has_many :quizzs, through: :topicquizzs

end
