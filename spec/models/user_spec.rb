require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
    it { should validate_presence_of :role }

    it { should validate_uniqueness_of :email }
  end

  describe 'Relationships' do
    it { should have_many :orders } # for customers
    it { should have_many :items } # for merchants
  end

  describe 'Class Method(s)' do
    it '.permit_email?' do
      user_1 = create(:user)

      actual = User.permit_email?(user_1.email)
      expected = false

      expect(actual).to eq(expected)

      actual = User.permit_email?('new_email@gmail.com')
      expected = true

      expect(actual).to eq(expected)
    end
  end

  describe 'Instance Method(s)' do
    describe '#top_five_items_sold' do
      it 'returns the top five items sold and quantity_sold' do
        @merchant = create(:merchant)

        @item_1 = create(:item, user: @merchant, quantity: 10)
        @item_2 = create(:item, user: @merchant, quantity: 10)
        @item_3 = create(:item, user: @merchant, quantity: 10)
        @item_4 = create(:item, user: @merchant, quantity: 10)
        @item_5 = create(:item, user: @merchant, quantity: 10)
        @item_6 = create(:item, user: @merchant, quantity: 10)


        @order_item_0 = create(:order_item, item: @item_1, quantity: 1)
        @order_item_1 = create(:order_item, item: @item_1, quantity: 1)
        @order_item_2 = create(:order_item, item: @item_2, quantity: 2)
        @order_item_3 = create(:order_item, item: @item_3, quantity: 3)
        @order_item_4 = create(:order_item, item: @item_4, quantity: 4)
        @order_item_5 = create(:order_item, item: @item_5, quantity: 5)
        @order_item_6 = create(:order_item, item: @item_6, quantity: 6)
        @order_item_7 = create(:order_item, item: @item_6, quantity: 6)

        expected = [@item_6, @item_5, @item_4, @item_3, @item_1]

        expect(@merchant.top_five_items_sold).to eq(expected)
      end
    end

    describe '#percent_inventory_sold' do
      it 'returns percentage against my sold units plus remaining inventory' do
        # (eg, if I have sold 10 things and still have 90 things in inventory,
        # the message would say something like
        # "Sold 10 items, which is 10% of your total inventory"
        merchant = create(:merchant)
        i1, i2, i3, i4, i5, i6, i7, i8, i9 = create_list(:item, 9, quantity: 10, user: merchant)
        oi1 = create(:fulfilled_order_item, quantity: 10, item: i1)

        expect(merchant.percent_inventory_sold).to eq(10)
      end
    end

    describe '#items_sold' do
      it 'returns total items a merchant has sold' do
        merchant = create(:merchant)
        item = create(:item, user: merchant)
        order_item = create(:fulfilled_order_item, quantity: 10, item: item)

        expect(merchant.items_sold).to eq(10)
      end
    end

    describe '#top_three_states' do
      it 'returns top 3 states where my items shipped' do
        merchant = create(:merchant)
        item = create(:item, user: merchant)

        co_user = create(:user, state: "CO")
        il_user = create(:user, state: "IL")
        az_user = create(:user, state: "AZ")
        fl_user = create(:user, state: "FL")

        co_order = create(:shipped_order, user: co_user)
        il_order = create(:shipped_order, user: il_user)
        az_order = create(:shipped_order, user: az_user)
        fl_order = create(:shipped_order, user: fl_user)

        co_order_item = create(:fulfilled_order_item, quantity: 10, item: item, order: co_order)
        il_order_item = create(:fulfilled_order_item, quantity: 9, item: item, order: il_order)
        az_order_item = create(:fulfilled_order_item, quantity: 8, item: item, order: az_order)
        fl_order_item = create(:fulfilled_order_item, quantity: 1, item: item, order: fl_order)

        active_record = merchant.top_three_states_with_quantity_sold
        states = active_record.map { |relation| relation.state }
        quantity_sold = active_record.map { |relation| relation.quantity_sold }

        expect(states).to eq(["CO", "IL", "AZ"])
        expect(quantity_sold).to eq([10, 9, 8])
      end
    end

    describe '#best_customer' do
      it 'returns name and order_count of the user with the most orders from me' do
        merchant = create(:merchant)
        item = create(:item, user: merchant)

        co_user = create(:user, state: "CO")
        co_order_1 = create(:shipped_order, user: co_user)
        co_order_item_1 = create(:fulfilled_order_item, quantity: 10, item: item, order: co_order_1)
        co_order_2 = create(:shipped_order, user: co_user)
        co_order_item_2 = create(:fulfilled_order_item, quantity: 10, item: item, order: co_order_2)

        il_user = create(:user, state: "IL")
        il_order = create(:shipped_order, user: il_user)
        il_order_item = create(:fulfilled_order_item, quantity: 9, item: item, order: il_order)

        expect(merchant.best_customer.name).to eq(co_user.name)
        expect(merchant.best_customer.order_count).to eq(2)
      end
    end

    it '#disable_merchant_items' do
      admin = create(:admin)
      merchant = create(:merchant)
      item_1 = create(:item)
      item_2 = create(:item)
      item_3 = create(:item)
      merchant.items << item_1
      merchant.items << item_2
      merchant.items << item_3
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      expect(item_1.enabled).to eq(true)
      expect(item_2.enabled).to eq(true)
      expect(item_3.enabled).to eq(true)
      merchant.disable_merchant_items
      expect(item_1.enabled).to eq(false)
      expect(item_2.enabled).to eq(false)
      expect(item_3.enabled).to eq(false)
    end

    it '#enable_merchant_items' do
      admin = create(:admin)
      merchant = create(:merchant)
      item_1 = create(:inactive_item)
      item_2 = create(:inactive_item)
      item_3 = create(:inactive_item)
      merchant.items << item_1
      merchant.items << item_2
      merchant.items << item_3
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      merchant.enable_merchant_items
      expect(item_1.enabled).to eq(true)
      expect(item_2.enabled).to eq(true)
      expect(item_3.enabled).to eq(true)
    end

    it '#pending_orders' do
      merchant = create(:merchant)
      #creates 3 order_items and 3 associated items/pending orders
      oi_1, oi_2, oi_3 = create_list(:order_item, 3)
      #creates second item associated with same order
      oi_4 = create(:order_item, order: oi_1.order)
      #creates order_item and order with shipped status
      fulfilled_oi_1 = create(:fulfilled_order_item, order: create(:shipped_order))
      #creates items associated with a specific merchant of fulfilled and unfulfilled order_items
      merchant.items << [oi_1.item, oi_2.item, fulfilled_oi_1.item]

      actual = merchant.pending_orders
      expected = [oi_1.order, oi_2.order]
      expect(actual).to eq(expected)
    end
  end
end
