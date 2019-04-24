require 'rails_helper'

RSpec.describe 'Merchant cannot fulfill an order due to lack of inventory', type: :feature do
  context 'as a logged in merchant with pending orders, viewing my dashboard' do
    context 'If the user desired quantity is greater than my current inventory quantity for that item' do
      before :each do
        @merchant = create(:merchant)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

        @item_1 = create(:item, user: @merchant, quantity: 1)
        @order = create(:order)
        @order_item_1 = create(:order_item, order: @order, item: @item_1, quantity: 10)

        visit dashboard_order_path(@order)
      end

      it 'does not show a fulfill link' do
        within "#item-card-#{@item_1.id}" do
          expect(page).to_not have_link "Fulfill Item"
        end
      end

      it 'shows a big red notice next to the item indicating I cannot fulfill this item' do
        within "#item-card-#{@item_1.id}" do
          expect(page).to have_content "Not Enough Stock to Fulfill Item"
        end
      end
    end
  end
end
