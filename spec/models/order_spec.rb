require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :status }
  end

  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many :order_items }
    it { should have_many(:items).through(:order_items) }
  end

  describe 'Instance Method(s)' do
    describe '#grand_total' do
      it 'returns the grand total $ amount for an order' do
        item_1 = create(:item)
        item_2 = create(:item)
        order = create(:order)
        order_item_1 = create(:order_item, order: order, item: item_1)
        order_item_2 = create(:order_item, order: order, item: item_2)

        expected = (order_item_1.order_price * order_item_1.quantity) + (order_item_2.order_price * order_item_2.quantity)

        expect(order.grand_total).to eq(expected)
      end
    end

    describe '#total_quantity' do
      it 'returns the total quantity of items for an order' do
        oi_1 = create(:order_item)
        #creates three order_items and items bound to same order from oi_1
        oi_2, oi_3, oi_4 = create_list(:order_item, 3, order: oi_1.order)
        #main order for clarity in test
        order_1 = oi_1.order
        #total quantity of items in a single order
        actual = order_1.total_quantity

        expected = [oi_1, oi_2, oi_3, oi_4].sum { |oi| oi.quantity }

        expect(actual).to eq(expected)
      end
    end

    describe '#pending_to_packaged' do
      it 'change order status to pending when all items are fullfilled' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        #syntax to create multiple items and assign them to a chosen merchant
        item_1, item_2, item_3 = create_list(:item, 3, user: merchant_1)
        item_4, item_5, item_6 = create_list(:item, 3, user: merchant_2)
        order = create(:order)
        oi_1 = create(:fulfilled_order_item, item: item_1, order: order)
        oi_2 = create(:fulfilled_order_item, item: item_2, order: order)
        oi_3 = create(:fulfilled_order_item, item: item_3, order: order)
        oi_4 = create(:fulfilled_order_item, item: item_4, order: order)
        oi_5 = create(:fulfilled_order_item, item: item_5, order: order)
        oi_6 = create(:fulfilled_order_item, item: item_6, order: order)

        order.pending_to_packaged

        actual = order.status
        expected = 'packaged'
        expect(actual).to eq(expected)
      end
    end
  end
end
