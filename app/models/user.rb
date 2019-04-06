class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zipcode
  validates_presence_of :role
  validates :email, presence: true, uniqueness: true

  has_many :orders
  has_many :items

  has_secure_password

  enum role: ['user', 'merchant', 'admin']

  def disable_merchant_items
    items.each {|item| item.disable}
  end
end
