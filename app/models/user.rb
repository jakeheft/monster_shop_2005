class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true
  validates_presence_of :name, :address, :city, :state, :zip, :email, :password, require: true

  validates :password, confirmation: { case_sensitive: true }
  validates :password_confirmation, presence: true
end
