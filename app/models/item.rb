class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :quantity
  validates_presence_of :price

  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def disable
    update(enabled: false)
  end

  def subtotal(quantity)
    self.price * quantity
  end

  def average_fulfilled_time
    fulfillment = Item.joins(:order_items)
                      .select("avg(order_items.updated_at - order_items.created_at) as average_time")
                      .where(id: self.id, order_items: {fulfilled: true})
                      .group(:id).first

    if fulfillment
      fulfillment.average_time
    else
      "no fulfillment data available for this item"
    end
  end

  def self.five_most_popular
    Item.joins(:order_items)
    .select("items.*, sum(order_items.quantity) as total_fulfilled")
    .where(order_items: {fulfilled: true}, items: {enabled: true})
    .group(:id)
    .order("total_fulfilled desc")
    .limit(5)
  end

  def self.five_least_popular
    Item.joins(:order_items)
    .select("items.*, sum(order_items.quantity) as total_fulfilled")
    .where(order_items: {fulfilled: true}, items: {enabled: true})
    .group(:id)
    .order("total_fulfilled asc")
    .limit(5)
  end

  def order_quantity(order_id)
    OrderItem.find_by(order_id: order_id).quantity
  end

  def ordered_price(order_id)
    OrderItem.find_by(order_id: order_id).order_price
  end

  def order_subtotal(order_id)
    order_quantity(order_id) * ordered_price(order_id)
  end

end
