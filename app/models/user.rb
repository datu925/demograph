class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  has_secure_password

  has_many :notifications
  has_many :events, through: :notifications
end
