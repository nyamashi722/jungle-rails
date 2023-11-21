class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }
  
  before_validation :downcase_email

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    return user if user&.authenticate(password)
    nil
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
