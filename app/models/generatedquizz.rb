class Generatedquizz < ApplicationRecord

  before_create :generate_code

  belongs_to :quizz
  belongs_to :user
  has_many :answeredquizzs

  validates_uniqueness_of :user_id, scope: :quizz_id


  def generate_code
    self.code = loop do
      random_code = SecureRandom.urlsafe_base64(5)
      break random_code unless self.class.exists?(code: random_code)
    end
  end

end
