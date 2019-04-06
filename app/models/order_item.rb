class OrderItem < ApplicationRecord
  validates_presence_of :order_price
  validates_presence_of :quantity
  
  belongs_to :order
  belongs_to :item
end
