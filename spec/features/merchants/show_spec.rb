require 'rails_helper'

RSpec.describe 'Dashboard Show Page' do
  context '*as a merchant user' do
    describe '*happy path' do
      before(:each) do
        @merchant = create(:merchant)

        visit root_path

        click_link "Login"

        expect(current_path).to eq(login_path)
        fill_in "email", with: @merchant.email
        fill_in "password", with: @merchant.password
        click_button "Log In"
      end

      it '*can see all the appropriate user data on profile' do

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content(@merchant.name)
        expect(page).to have_content("Email: #{@merchant.email}")
        expect(page).to have_content(@merchant.street)
        expect(page).to have_content("#{@merchant.city}, #{@merchant.state} #{@merchant.zipcode}")
        expect(page).to_not have_content(@merchant.password)
        expect(page).to_not have_link('Edit Details')
      end

      it '*can see all the orders on dashboard' do
        oi_1, oi_2, oi_3 = create_list(:order_item, 3)
        oi_4 = create(:order_item, order_id: oi_1.order.id, order: oi_1.order)
        fulfilled_oi_1 = create(:fulfilled_order_item)

        #creates items associated with a specific merchant of fulfilled and unfulfilled order_items
        @merchant.items << [oi_1.item, oi_2.item, fulfilled_oi_1.item]

        within('#pending-order-ctn') do
          within("#pending-order-card-#{oi_1.order.id}") do
            expect(page).to have_link(oi_1.order.id)
            expect(page).to have_content(oi_1.created_at)
            expect(page).to have_content('Quantity: 1')
            expect(page).to have_content('Total Value: $3.00') # came from FactoryBot pry session
          end

          within("#pending-order-card-#{oi_2.order.id}") do
            expect(page).to have_link(oi_2.order.id)
            expect(page).to have_content(oi_2.created_at)
            expect(page).to have_content('Quantity: 1')
            expect(page).to have_content('Total Value: $4.50') # came from FactoryBot pry session
          end
        end
      end
    end
  end
end
