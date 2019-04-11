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
    describe "#enough_stock_for_order(order_quantity)" do
      it 'returns true if inventory >= order_quantity' do
        item = create(:item, quantity: 2)
        order_quantity_1 = 1
        order_quantity_2 = 2

        expect(item.enough_stock_for_order(order_quantity_1)).to eq(true)
        expect(item.enough_stock_for_order(order_quantity_2)).to eq(true)
      end

      it 'returns false if inventory < order_quantity' do
        item = create(:item, quantity: 1)
        order_quantity = 2

        expect(item.enough_stock_for_order(order_quantity)).to eq(false)
      end
    end

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

      it 'should return a no fullfillment data message if there are no orders' do
        item = create(:item)

        expect(item.average_fulfilled_time).to include("no fulfillment data available for this item")
      end
    end

    describe '.disable' do
      it 'should change item status to disabled' do
        item = create(:item)
        expect(item.enabled).to eq(true)
        item.disable
        expect(item.enabled).to eq(false)
      end
    end


    describe '.enable' do
      it 'should change item status to enabled' do
        item = create(:inactive_item)
        expect(item.enabled).to eq(false)
        item.enable
        expect(item.enabled).to eq(true)
      end
    end

    describe '.order_quantity' do
      it 'should get the item quantity for an order' do
        @order_1 = create(:order)
        @item_1 = create(:item)

        @order_item_1= create(:fulfilled_order_item, order: @order_1, item: @item_1, quantity: 2)

        expect(@item_1.order_quantity(@order_1.id)).to eq(2)
      end
    end

    describe '.order_quantity' do
      it 'should get the item quantity for an order' do
        @order_1 = create(:order)
        @item_1 = create(:item)

        @order_item_1= create(:fulfilled_order_item, order: @order_1, item: @item_1, quantity: 2)

        expect(@item_1.order_quantity(@order_1.id)).to eq(2)
      end
    end

    describe '.order_price' do
      it 'should get the item price for an order' do
        @order_1 = create(:order)
        @item_1 = create(:item)

        @order_item_1= create(:fulfilled_order_item, order: @order_1, item: @item_1, quantity: 2, order_price: 3.50)

        expect(@item_1.order_price(@order_1.id)).to eq(3.50)
      end
    end

    describe '.order_subtotal' do
      it 'should get the item price for an order' do
        @order_1 = create(:order)
        @item_1 = create(:item)

        @order_item_1= create(:fulfilled_order_item, order: @order_1, item: @item_1, quantity: 2, order_price: 3.50)

        expect(@item_1.order_subtotal(@order_1.id)).to eq(7)
      end
    end
  end

  describe 'class methods' do
    it "finds the #five_most_popular and #five_least_popular" do

      @merchant = create(:merchant)
      @user = create(:user)

      @item_1 = create(:inactive_item)
      @item_2 = create(:item, quantity: 30)
      @item_3 = create(:item, quantity: 30)
      @item_4 = create(:item, quantity: 30)
      @item_5 = create(:item, quantity: 30)
      @item_6 = create(:item, quantity: 30)
      @item_7 = create(:item, quantity: 30)
      @item_8 = create(:item, quantity: 30)
      @item_9 = create(:item, quantity: 30)
      @item_10 = create(:item, quantity: 30)
      @item_11 = create(:item, quantity: 30)

      @order_1 = create(:order, user: @user)
      @order_2 = create(:shipped_order, user: @user)
      @order_3 = create(:shipped_order, user: @user)

      @order_item_1= create(:fulfilled_order_item, item: @item_1, order: @order_1)
      @order_item_2= create(:fulfilled_order_item, item: @item_2, order: @order_2, quantity: 20)
      @order_item_3= create(:fulfilled_order_item, item: @item_3, order: @order_2, quantity: 18 )
      @order_item_4= create(:fulfilled_order_item, item: @item_4, order: @order_2, quantity: 16 )
      @order_item_5= create(:fulfilled_order_item, item: @item_5, order: @order_2, quantity: 14 )
      @order_item_6= create(:fulfilled_order_item, item: @item_6, order: @order_2, quantity: 12 )
      @order_item_7= create(:fulfilled_order_item, item: @item_7, order: @order_3, quantity: 10 )
      @order_item_8= create(:fulfilled_order_item, item: @item_8, order: @order_3, quantity: 9 )
      @order_item_9= create(:fulfilled_order_item, item: @item_9, order: @order_3, quantity: 8 )
      @order_item_10= create(:fulfilled_order_item, item: @item_10, order: @order_3, quantity: 6 )
      @order_item_11= create(:fulfilled_order_item, item: @item_11, order: @order_3, quantity: 2 )
      @order_item_12= create(:fulfilled_order_item, item: @item_11, order: @order_3, quantity: 2 )

      expect(Item.five_most_popular).to eq([@item_2,@item_3,@item_4,@item_5,@item_6])
      expect(Item.five_least_popular).to eq([@item_11,@item_10,@item_9,@item_8,@item_7])
    end
  end
end
