class User < ApplicationRecord

  before_create :confirmation_token

  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /@/

  # TEACHER
  has_many :exercises
  has_many :comments
  has_many :conceptualmodels
  has_many :quizzs
  has_many :generatedquizzs

  # STUDENT
  has_many :answeredexercises
  has_many :answeredquizzs


  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end
