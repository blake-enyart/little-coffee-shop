require 'rails_helper'

RSpec.describe Cart do
  subject {       # subject is RSpec similar to before :each
    Cart.new({
      '1' => 2,   # two copies of item 1
      '2' => 3    # three copies of item 2
    })
  }

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
end
