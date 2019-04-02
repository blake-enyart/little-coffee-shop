class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :quantity
  validates_presence_of :price
  validates_presence_of :enabled

  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items
end
