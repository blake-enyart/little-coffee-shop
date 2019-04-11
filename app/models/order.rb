class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['pending', 'packaged', 'shipped', 'cancelled']

  def grand_total
    self.order_items.sum("quantity * order_price")
  end

  def total_quantity
    self.order_items.sum(:quantity)
  end

  def self.sort_by_status
    Order.order("status=3, status=2, status=0, status=1")
  end
end
