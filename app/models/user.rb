class User < ActiveRecord::Base
  has_many :businesses, dependent: :nullify

  validates :email, :last_name,  :first_name, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password
end
