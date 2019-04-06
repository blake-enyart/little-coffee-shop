class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :quantity
  validates_presence_of :price

  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items


  def subtotal(quantity)
    self.price * quantity
  end
  
  def average_fulfilled_time
    fulfillment = Item.joins(:order_item)
                      .select("avg(order_items.updated_at - order_items.created_at) as average_time")
                      .where(id: self.id, order_items: {fulfilled: true})
                      .group(:id).first

    if fulfillment
      fulfillment.average_time
    else
      "no fulfillment data available for this item"
    end
  end
end
