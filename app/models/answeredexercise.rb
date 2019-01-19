class Answeredexercise < ApplicationRecord
  belongs_to :exercise
  belongs_to :user
end
