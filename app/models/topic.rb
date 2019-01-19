class Topic < ApplicationRecord

  has_many :topicexercises
  has_many :exercises, through: :topicexercises

end
