require 'rails_helper'

RSpec.describe 'Dashboard Show Page' do
  context '*as a merchant user' do
    describe '*happy path' do

      it '*can see all the appropriate user data on profile' do
        @merchant = create(:merchant)

        visit root_path

        click_link "Login"

        expect(current_path).to eq(login_path)
        fill_in "email", with: @merchant.email
        fill_in "password", with: @merchant.password
        click_button "Log In"

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content(@merchant.name)
        expect(page).to have_content("Email: #{@merchant.email}")
        expect(page).to have_content(@merchant.street)
        expect(page).to have_content("#{@merchant.city}, #{@merchant.state} #{@merchant.zipcode}")
        expect(page).to_not have_content(@merchant.password)
        expect(page).to_not have_link('Edit Details')
      end

      it '*can see all the orders on dashboard' do
        merchant = create(:merchant)
        #creates 3 order_items and 3 associated items/pending orders
        oi_1, oi_2, oi_3 = create_list(:order_item, 3)
        #creates second item associated with same order
        oi_4 = create(:order_item, order_id: oi_1.order.id, order: oi_1.order)
        #creates order_item and order with shipped status
        fulfilled_oi_1 = create(:fulfilled_order_item, order: create(:shipped_order))
        #creates items associated with a specific merchant of fulfilled and unfulfilled order_items
        merchant.items << [oi_1.item, oi_2.item, fulfilled_oi_1.item]

        visit root_path

        click_link "Login"

        expect(current_path).to eq(login_path)
        fill_in "email", with: merchant.email
        fill_in "password", with: merchant.password
        click_button "Log In"

        within("#pending-orders") do
          within("#pending-order-card-#{oi_1.order.id}") do
            expect(page).to have_link(oi_1.order.id.to_s)
            expect(page).to have_content(oi_1.created_at)
            expect(page).to have_content("Quantity: #{oi_1.order.total_quantity}")
            expect(page).to have_content("Total Value: $#{oi_1.order.grand_total}") # came from FactoryBot pry session
          end

          within("#pending-order-card-#{oi_2.order.id}") do
            expect(page).to have_link(oi_2.order.id.to_s)
            expect(page).to have_content(oi_2.created_at)
            expect(page).to have_content("Quantity: #{oi_2.order.total_quantity}")
            expect(page).to have_content("Total Value: $#{oi_2.order.grand_total}") # came from FactoryBot pry session
          end
          expect(page).to_not have_css("#pending-order-card-#{fulfilled_oi_1.order.id}")
          expect(page).to_not have_css("#pending-order-card-#{oi_3.order.id}")
        end

      end

    end
  end
end
