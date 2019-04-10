class OrderItem < ApplicationRecord
  validates_presence_of :order_price
  validates_presence_of :quantity

  belongs_to :order
  belongs_to :item

  def fulfill_item
    # Item quantity (aka inventory) -= OrderItem.quantity (aka ordered quantity)
    self.item.update(quantity: self.item.quantity - self.quantity)

    self.update(fulfilled: true)
  end
end
