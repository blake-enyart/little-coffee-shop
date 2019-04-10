require 'rails_helper'

RSpec.describe 'Merchant fulfills part of an order', type: :feature do
  context 'as a logged in merchant with pending orders, viewing my dashboard' do
    context 'if the users order quantity is <= than my current inventory quantity' do
      context 'and the item is not fulfilled' do
        it 'allows me to fulfill that item' do
          @merchant = create(:merchant)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

          @item_1 = create(:item, user: @merchant, quantity: 10)

          @order = create(:order)
          @order_item_1 = create(:order_item, order: @order, item: @item_1, quantity: 1)

          visit dashboard_order_path(@order)

          within "#item-card-#{@item_1.id}" do
            click_on "Fulfill Item"
          end
          @merchant.reload
          @item_1.reload

          expect(current_path).to eq(dashboard_order_path(@order))

          within "#item-card-#{@item_1.id}" do
            expect(page).to have_content("Item Already Fulfilled")
          end

          expect(page).to have_content("Item #{@item_1.name} has been fulfilled successfully.")

          visit dashboard_items_path

          within "#merchant-item-#{@item_1.id}" do      # Started with 10 when creating @item_1
            expect(page).to have_content("Inventory: 9") # @order_item_1 was for quantity 1
          end                                           # 10 - 1 = 9
        end
      end
    end
  end
end
