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
