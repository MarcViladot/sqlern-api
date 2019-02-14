class Answeredquizz < ApplicationRecord
  belongs_to :user
  belongs_to :generatedquizz
  has_many :joinanswereds
  has_many :answeredexercises, through: :joinanswereds

  validates_uniqueness_of :generatedquizz_id, scope: :user_id
end
