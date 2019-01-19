class Answeredquizz < ApplicationRecord
  belongs_to :user
  belongs_to :generatedquizz
  has_many :joinanswereds
  has_many :answeredexercises, through: :joinanswereds
end
