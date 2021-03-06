class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
    @contents.default = 0
  end

  def total_count
    @contents.values.sum
  end

  def add_item(id)
    @contents[id.to_s] = @contents[id.to_s] + 1
  end

  def deduct_item(id)
    @contents[id.to_s] -= 1
    @contents.delete(id.to_s) if @contents[id.to_s] == 0
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def items
    items_hash = Hash.new(0)
    @contents.each do |item_id, quantity|
      item = Item.find(item_id)
      items_hash[item] = quantity
    end
    items_hash
  end

  def grand_total
    items.sum { |item, quantity| item.price * quantity }
  end

  def empty?
    @contents.count == 0
  end

  def empty_cart
    @contents.clear
  end

  def generate_order(user)
    order = user.orders.create

    self.items.each do |item, quantity|
      order.order_items.create(
        item_id: item.id,
        order_price: item.price,
        quantity: quantity
      )
    end
  end

end
