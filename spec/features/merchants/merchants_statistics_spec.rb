require 'rails_helper'

RSpec.describe "All users can see a merchants index page", type: :feature do
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
    # require 'pry'; binding.pry
  end

  context 'statistics section' do
    it 'can see top three merchants by price' do

      visit merchants_path

      within "#best-sellers" do
        save_and_open_page
        expect(page).to have_content("#{@merchant_5.name} : $663.0")
        expect(page).to have_content("#{@merchant_4.name} : $435.0")
        expect(page).to have_content("#{@merchant_3.name} : $255.0")
      end
    end
    it 'can see top three merchants by fasest fullfillment time' do

      visit merchants_path

      within "#fastest-sellers" do

        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_3.name)
      end
    end
    it 'can see bottom three merchants by fastest fullfillment time' do

      visit merchants_path

      within "#slowest-sellers" do
        expect(page).to have_content(@merchant_5.name)
        expect(page).to have_content(@merchant_4.name)
        expect(page).to have_content(@merchant_3.name)
      end
    end
  end
end