class OrderItem < ApplicationRecord
  validates_presence_of :order_price
  validates_presence_of :quantity
  validates_presence_of :fulfilled
  
  belongs_to :order
  belongs_to :item
end
