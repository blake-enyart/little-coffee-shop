require 'rails_helper'

RSpec.describe 'Merchant Dashboard Statistics', type: :feature do
  context 'As a logged in Merchant viewing my dashboard statistics' do
    before :each do
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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
      visit dashboard_path
    end

    it 'shows the top 5 items I have sold by quantity, and the quantity of each that Ive sold' do
      within "#top-5-items-sold" do
        expect(page).to have_content("#{@item_6.name} - 12 #{@item_5.name} - #{@order_item_5.quantity} #{@item_4.name} - #{@order_item_4.quantity} #{@item_3.name} - #{@order_item_3.quantity} #{@item_1.name} - 2")
      end
    end

    xit 'shows the total quantity of items Ive sold and a a percentage against my sold units plus remaining inventory'
    # (eg, if I have sold 1,000 things and still have 9,000 things in inventory,
    # the message would say something like
    # "Sold 1,000 items, which is 10% of your total inventory"

    xit 'shows top 3 states where my items were shipped, and their quantities'

    xit 'shows top 3 city/state where my items were shipped, and their quantities'

    xit 'shows name of the user with the most orders from me and number of orders'
    # - (pick one if there's a tie)

    xit 'shows the name of the user who bought the most total items from me and the total quantity'
    # (pick one if there's a tie)

    xit 'shows top 3 users who have spent the most money on my items, and the total amount theyve spent'
  end
end