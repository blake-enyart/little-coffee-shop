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
