require 'rails_helper'

RSpec.describe Cart do
  subject {       # subject is RSpec similar to before :each
    Cart.new({
      '1' => 2,   # two copies of item 1
      '2' => 3    # three copies of item 2
    })
  }

  before :each do
    @item_1 = create(:item)
    @item_2 = create(:item)
    @cart = Cart.new({
      @item_1.id => 2,   # two copies of item 1
      @item_2.id => 3    # three copies of item 2
      })
  end

  describe "#total_count" do
    it 'can calculate the total number of items it holds' do
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_item" do
    it 'adds an item to its contents' do
      subject.add_item(1)
      subject.add_item(2)

      expect(subject.contents).to eq({'1' => 3, '2' => 4})
    end
  end

  describe "#count_of" do
    it 'adds returns the count of an item_id in the cart' do
      expect(subject.count_of(1)).to eq(2) # two copies of item 1
      expect(subject.count_of(5)).to eq(0) # zero copies of item 5
    end
  end

  describe "#items" do
    it 'returns a hash where the keys are Item objects and values are quantites' do
      expected = {
        @item_1 => 2,
        @item_2 => 3
      }

      expect(@cart.items).to eq(expected)
    end
  end

  describe "#sub_total(item, quantity)" do
    it 'returns a sub_total based on an item and desired quantity' do
      quantity = @cart.contents[@item_1.id]
      expected = @item_1.price * quantity

      expect(@cart.sub_total(@item_1, quantity)).to eq(expected)
    end
  end

  describe "#grand_total" do
    it 'returns a grand total price of all items in cart' do
      item_1_quantity = @cart.contents[@item_1.id]
      item_2_quantity = @cart.contents[@item_2.id]

      expected = @item_1.price * item_1_quantity + @item_2.price * item_2_quantity

      expect(@cart.grand_total).to eq(expected)
    end
  end
end
