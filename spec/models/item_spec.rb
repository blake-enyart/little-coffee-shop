require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :price }
  end

  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many :order_items }
    it { should have_many(:orders).through(:order_items) }
  end

  describe 'Instance methods' do
    describe "#subtotal(quantity)" do
      it 'returns a subtotal aka item.price * quantity argument' do
        item = create(:item)
        quantity = 2
        expected = item.price * quantity

        expect(item.subtotal(quantity)).to eq(expected)
      end
    end


    describe ".average_fulfilled_time" do
      it 'should calculate average fulfillment time for an item' do
        merchant = create(:merchant)
        user = create(:user)
        item = create(:item)

        order_1 = create(:shipped_order, user: user)
        order_2 = create(:shipped_order, user: user)
        order_3 = create(:shipped_order, user: user)

        order_item_1= create(:fulfilled_order_item, item: item, order: order_1, created_at: 3.days.ago)
        order_item_2= create(:fulfilled_order_item, item: item, order: order_2, created_at: 2.days.ago)
        order_item_3= create(:fulfilled_order_item, item: item, order: order_3, created_at: 6.days.ago)

        expect(item.average_fulfilled_time).to include("3 days 16:00")
      end
      
      it 'should calculate average fulfillment time for an item' do

        item = create(:item)

        expect(item.average_fulfilled_time).to include("no fulfillment data available for this item")
      end
    end
  end
end
