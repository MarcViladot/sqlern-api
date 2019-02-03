class Topicquizz < ApplicationRecord
  belongs_to :quizz
  belongs_to :topic
end
