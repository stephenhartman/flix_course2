class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, format: /\A[A-Z0-9]+\z/i, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: /\A\S+@\S+.\S+\z/, uniqueness: { case_sensitive: false }
  has_secure_password

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end
end
