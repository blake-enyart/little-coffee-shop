require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :order_price }
    it { should validate_presence_of :quantity }
  end

  describe 'Relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
  end

  describe 'Instance methods' do
    describe '#fulfill_item' do
      it 'changes fulfilled to true of order_item and deducts that item inventory' do
        @merchant = create(:merchant)
        @item_1 = create(:item, user: @merchant, quantity: 10)

        @order = create(:order)
        @order_item = create(:order_item, order: @order, item: @item_1, quantity: 1)

        expect(@order_item.fulfilled).to eq(false)

        @order_item.fulfill_item
        @order_item.reload

        expect(@order_item.fulfilled).to eq(true)

        @item_1.reload
        expect(@item_1.quantity).to eq(9)
      end
    end
  end
end
