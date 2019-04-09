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

  def self.top_three_sellers
    result = User.joins(items: :order_items).select("users.*, sum(order_items.order_price * order_items.quantity) as total_revenue").where("order_items.fulfilled = 'true'").group(:id).order("total_revenue DESC").limit(3)
  end

  def self.fastest_fulfillment
    result = User.joins(items: :order_items).select('users.*, avg(order_items.updated_at - order_items.created_at) as fill_time').where("order_items.fulfilled = 'true'").group(:id).order("fill_time ASC").limit(3)
  end

  def self.slowest_fulfillment
    result = User.joins(items: :order_items).select('users.*, avg(order_items.updated_at - order_items.created_at) as fill_time').where("order_items.fulfilled = 'true'").group(:id).order("fill_time DESC").limit(3)
  end
  
  def disable_merchant_items
    items.each {|item| item.disable}
  end
end
