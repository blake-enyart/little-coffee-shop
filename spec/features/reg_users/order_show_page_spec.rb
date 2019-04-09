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


      end
    end
  end
end

# As a registered user
# When I visit my Profile Orders page
# And I click on a link for order's show page
# My URL route is now something like "/profile/orders/15"
# I see all information about the order, including the following information:
# - the ID of the order
# - the date the order was made
# - the date the order was last updated
# - the current status of the order
# - each item I ordered, including name, description, thumbnail, quantity, price and subtotal
# - the total quantity of items in the whole order
# - the grand total of all items for that order
