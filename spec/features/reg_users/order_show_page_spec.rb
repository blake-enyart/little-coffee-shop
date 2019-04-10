require 'rails_helper'

RSpec.describe 'User Order Show Page' do
  describe 'when a registered user visits their profile orders page' do
    describe 'they click on an order id number' do
      it 'lets them see that order show page' do
        @user = create(:user)
        @order_1 = create(:order, user: @user)

        @item_1 = create(:item)
        @item_2 = create(:item)

        @order_item_1= create(:fulfilled_order_item, item: @item_1, order: @order_1)
        @order_item_2= create(:fulfilled_order_item, item: @item_2, order: @order_1)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit profile_orders_path
        click_on "#{@order_1.id}"

        expect(current_path).to eq(profile_order_path(@order_1))

        expect(page).to have_content("Order ID: #{@order_1.id}")
        expect(page).to have_content("Date of Order: #{@order_1.created_at}")
        expect(page).to have_content("Last Updated: #{@order_1.updated_at}")
        expect(page).to have_content("Status: #{@order_1.status}")

        within "#item-#{@item_1.id}" do
          expect(page).to have_content("#{@item_1.name}")
          expect(page).to have_css("img[src*='#{@item_1.image_url}']")
          expect(page).to have_content("Description: #{@item_1.description}")
          expect(page).to have_content("Quantity: #{@order_item_1.quantity}")
          expect(page).to have_content("Price: $#{@order_item_1.order_price}")
          expect(page).to have_content("Sub Total: $#{@order_item_1.subtotal}")
        end

        within "#item-#{@item_2.id}" do
          expect(page).to have_content("#{@item_2.name}")
          expect(page).to have_css("img[src*='#{@item_2.image_url}']")
          expect(page).to have_content("Description: #{@item_2.description}")
          expect(page).to have_content("Quantity: #{@order_item_2.quantity}")
          expect(page).to have_content("Price: $#{@order_item_2.order_price}")
          expect(page).to have_content("Sub Total: $#{@order_item_2.subtotal}")
        end
        expect(page).to have_content("Total Items: #{@order_1.total_quantity}")
        expect(page).to have_content("Grand Total: #{number_to_currency(@order_1.grand_total)}")
      end
    end
  end
end
