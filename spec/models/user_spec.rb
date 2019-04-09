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

  describe 'Class Methods' do
    it '.permit_email?' do
      user_1 = create(:user)

      actual = User.permit_email?(user_1.email)
      expected = false

      expect(actual).to eq(expected)

      actual = User.permit_email?('new_email@gmail.com')
      expected = true

      expect(actual).to eq(expected)
    end
    before :each do

      
        @merchant_1 = create(:merchant)
        @merchant_2 = create(:merchant)
        @merchant_3 = create(:merchant)
        @merchant_4 = create(:merchant)
        @merchant_5 = create(:merchant)
        @merchant_6 = create(:merchant)
        @user = create(:user)
   
  
        @item_1 = create(:item, price: 1.00, quantity: 30, user_id: @merchant_1.id)
        @item_2 = create(:item, price: 2.00, quantity: 30, user_id: @merchant_1.id)
        @item_3 = create(:item, price: 3.00, quantity: 30, user_id: @merchant_2.id)
        @item_4 = create(:item, price: 4.00, quantity: 30, user_id: @merchant_2.id)
        @item_5 = create(:item, price: 5.00, quantity: 30, user_id: @merchant_3.id)
        @item_6 = create(:item, price: 6.00, quantity: 30, user_id: @merchant_3.id)
        @item_7 = create(:item, price: 7.00, quantity: 30, user_id: @merchant_4.id)
        @item_8 = create(:item, price: 8.00, quantity: 30, user_id: @merchant_4.id)
        @item_9 = create(:item, price: 9.00, quantity: 30, user_id: @merchant_5.id)
        @item_10 = create(:item, price: 10.00, quantity: 30, user_id: @merchant_5.id)
  
        @order_1 = create(:order, user: @merchant_1)
        @order_2 = create(:order, user: @merchant_2)
        @order_3 = create(:order, user: @merchant_3)
        @order_4 = create(:order, user: @merchant_4)
        @order_5 = create(:order, user: @merchant_5)
        @order_6 = create(:order, user: @merchant_6)
  
  
        @order_item_1= create(:fulfilled_order_item, item: @item_1, order: @order_1, created_at: 1.days.ago)
        @order_item_2= create(:fulfilled_order_item, item: @item_2, order: @order_1, created_at: 1.days.ago)
        @order_item_3= create(:fulfilled_order_item, item: @item_3, order: @order_2, created_at: 2.days.ago)
        @order_item_4= create(:fulfilled_order_item, item: @item_4, order: @order_2, created_at: 2.days.ago)
  
        @order_item_5= create(:fulfilled_order_item, item: @item_5, order: @order_5, created_at: 3.days.ago)
        @order_item_6= create(:fulfilled_order_item, item: @item_6, order: @order_5, created_at: 3.days.ago)

        @order_item_7= create(:fulfilled_order_item, item: @item_7, order: @order_5, created_at: 4.days.ago)
        @order_item_8= create(:fulfilled_order_item, item: @item_8, order: @order_5, created_at: 4.days.ago)

        @order_item_9= create(:fulfilled_order_item, item: @item_9, order: @order_5, created_at: 5.days.ago)
        @order_item_10= create(:fulfilled_order_item, item: @item_10, order: @order_5, created_at: 5.days.ago)
  
        @order_item_11= create(:order_item, item: @item_1, order: @order_6)
        @order_item_12= create(:order_item, item: @item_2, order: @order_6)
      end
      
      # require 'pry'; binding.pry
      it '.top_three_sellers' do
        expect(User.top_three_sellers).to eq([@merchant_5, @merchant_4, @merchant_3])
      end
      it '.fastest_fulfillment' do
      expect(User.fastest_fulfillment).to eq([@merchant_1, @merchant_2, @merchant_3])
    end
      it '.slowest_fulfillment' do
      expect(User.slowest_fulfillment).to eq([@merchant_5, @merchant_4, @merchant_3])
    end
  end
  
  describe 'Instance Methods' do
    describe '#disable_merchant_items' do
      it 'disables all items for a merchant' do
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
    end
  end
end

