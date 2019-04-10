require 'rails_helper'

RSpec.describe 'Merchant Order Show Page', type: :feature do
  context '*as a merchant' do
    describe '*visit a order show page from the dashboard' do
      it '*displays correct information' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)

        item_1, item_2, item_3 = create_list(:item,3, user: merchant_1)
        item_4, item_5, item_6 = create_list(:item,3, user: merchant_2)
        order_1 = create(:order)

        oi_1 = create(:order_item, item: item_1, order: order_1)
        oi_2 = create(:order_item, item: item_2, order: order_1)
        oi_3 = create(:order_item, item: item_3, order: order_1)
        oi_4 = create(:order_item, item: item_4, order: order_1)
        oi_5 = create(:order_item, item: item_5, order: order_1)
        oi_6 = create(:order_item, item: item_6, order: order_1)

        allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(merchant_1)

        visit dashboard_path

        click_link(order_1.id.to_s)
        expect(current_path).to eq(dashboard_order_path(order_1))
        expect(page).to have_content("Order Number: #{order_1.id}")
        expect(page).to have_content("Customer Name: #{order_1.user.name}")
        expect(page).to have_content("Customer Address:\n#{order_1.user.street}")
        expect(page).to have_content("#{order_1.user.city}, #{order_1.user.state}")

        within("#item-card-#{item_1.id}") do
          expect(page).to have_link(item_1.name, href: item_path(item_1))
          expect(page).to have_css("img[src='#{item_1.image_url}']")
          expect(page).to have_content("Item Price: #{oi_1.order_price}")
          expect(page).to have_content("Quantity: #{oi_1.quantity}")
        end

        within("#item-card-#{item_2.id}") do
          expect(page).to have_link(item_2.name, href: item_path(item_2))
          expect(page).to have_css("img[src='#{item_2.image_url}']")
          expect(page).to have_content("Item Price: #{oi_2.order_price}")
          expect(page).to have_content("Quantity: #{oi_2.quantity}")
        end

        expect(page).to_not have_css("#item-card-#{item_4.id}")
        expect(page).to_not have_css("#item-card-#{item_5.id}")
        expect(page).to_not have_css("#item-card-#{item_6.id}")
      end
    end
  end
end
