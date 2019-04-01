class User < ApplicationRecord
  validates_presence_of :username
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zipcode
  validates_presence_of :password
  validates_presence_of :role
  validates_presence_of :enabled

  validates :email, presence: true, uniqueness: true

  has_many :orders

  has_secure_password
end
