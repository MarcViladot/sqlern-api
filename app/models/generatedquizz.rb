class Generatedquizz < ApplicationRecord
  belongs_to :quizz
  belongs_to :user
  has_many :answeredquizzs
end
