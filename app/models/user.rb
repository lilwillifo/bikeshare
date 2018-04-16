class User < ApplicationRecord
  has_secure_password
  validates_presence_of :username
  validates_presence_of :password, confirmation: true
  validates_uniqueness_of :username
  validates_presence_of :first_name, :last_name, :address

  enum role: %w[default admin]
  has_many :orders

  def full_name
    "#{first_name} #{last_name}"
  end
end
