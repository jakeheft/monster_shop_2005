class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true
  validates_presence_of :name, :address, :city, :state, :zip, :email, require: true
  validates :password, presence: true, on: :create

  validates :password, confirmation: { case_sensitive: true }
  validates :password_confirmation, presence: true, on: :create

  has_many :orders
  belongs_to :merchant, optional: true
  enum role: %w(user merchant admin)

  def valid_email
    return false if User.find_by(email: self.email)
  end
end
