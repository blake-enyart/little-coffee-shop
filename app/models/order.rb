class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['pending', 'packaged', 'shipped', 'cancelled']

  def total_quantity
    self.order_items.sum(:quantity)
  end

  def grand_total
    self.order_items.sum('quantity*order_price')
  end

end
