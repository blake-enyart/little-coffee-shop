require 'rails_helper'

RSpec.describe 'User cancels an order', type: :feature do
  context 'as a registered user viewing an order show page' do
    before :each do
      @merchant = create(:merchant)
      @item_1 = create(:item, user: @merchant, quantity: 10)
      @item_2 = create(:item, user: @merchant, quantity: 10)

      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      @order = create(:order, user: @user, status: 0)

      @unfulfilled_order_item = create(:order_item, order: @order, item: @item_1, quantity: 1)
      @fulffileed_order_item = create(:fulfilled_order_item, order: @order, item: @item_2, quantity: 1)

      visit order_path(@order)
    end

    scenario 'if the order is pending, I see a link to cancel the order' do
      expect(page).to have_link("Cancel Order")
    end

    scenario 'if the order is NOT pending, I do not see a link to cancel the order' do
      @packaged_order = create(:packaged_order)
      @shipped_order = create(:shipped_order)
      @cancelled_order = create(:cancelled_order)

      visit order_path(@packaged_order)
      expect(page).to_not have_link("Cancel Order")

      visit order_path(@shipped_order)
      expect(page).to_not have_link("Cancel Order")

      visit order_path(@cancelled_order)
      expect(page).to_not have_link("Cancel Order")
    end

    context 'clicking on the Cancel Order button' do
      it 'changes each row in the order_items table to status unfulfilled' do
        expect(@unfulfilled_order_item.fulfilled).to eq(false)
        expect(@fulffileed_order_item.fulfilled).to eq(true)

        click_on "Cancel Order"

        @unfulfilled_order_item.reload
        @fulffileed_order_item.reload

        expect(@unfulfilled_order_item.fulfilled).to eq(false)
        expect(@fulffileed_order_item.fulfilled).to eq(false)
      end

      it 'changes the order status to cancelled' do
        click_on "Cancel Order"
        @order.reload

        expect(@order.cancelled?).to eq(true)
      end

      it 'returns any previously fulfilled items to their respective inventory' do
        expect(@item_2.quantity).to eq(10)

        click_on "Cancel Order"
        @item_2.reload

        expect(@item_2.quantity).to eq(11)  # Because fulffileed_order_item.quantity is returned to inventory
      end

      it 'returns me to my profile page' do
        click_on "Cancel Order"

        expect(current_path).to eq(profile_path)
      end

      it 'shows a flash message telling me my order is now cancelled' do
        click_on "Cancel Order"

        expect(page).to have_content("Your order id <#{@order.id}> has been cancelled successfully.")
      end

      it 'shows the order with an updated status of cancelled' do
        click_on "Cancel Order"
        @order.reload
        visit order_path(@order)

        expect(page).to have_content("Status: cancelled")
      end
    end
  end
end
