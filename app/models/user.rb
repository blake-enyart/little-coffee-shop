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

  def self.permit_email?(email)
    if self.find_by(email: email)
      return false
    end
    true
  end

  def disable_merchant_items
    items.each {|item| item.disable}
  end

  def pending_orders
    #selects pending orders where the user id is the merchant id
    Order.joins(:items)
         .where('items.user_id = ? AND orders.status = 0',self.id)
         .distinct
  end
end
