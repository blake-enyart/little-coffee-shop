class User < ApplicationRecord
  validates_presence_of :name,
                        :street,
                        :city,
                        :state,
                        :zipcode,
                        :role

  validates :email, presence: true, uniqueness: true

  has_many :orders
  has_many :items

  has_secure_password allow_blank: true

  enum role: ['user', 'merchant', 'admin']
end
