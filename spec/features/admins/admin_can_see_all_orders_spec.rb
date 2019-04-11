require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  describe 'When an admin user logs into his dashbopard' do
    it 'lets them see all orders in the system' do
      @order_1 = create(:order)
      @order_2 = create(:packaged_order)
      @order_3 = create(:shipped_order)
      @order_4 = create(:cancelled_order)

      @admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      within "#order-#{@order_1.id}" do
        expect(page).to have_link(@order_1.user, href: admin_user_path(@order_1.user))
        expect(page).to have_content("Order ID: #{@order_1.id}")
        expect(page).to have_content("Date of Order: #{@order_1.created_at}")
      end
      within "#order-#{@order_2.id}" do
        expect(page).to have_link(@order_1.user, href: admin_user_path(@order_2.user))
        expect(page).to have_content("Order ID: #{@order_2.id}")
        expect(page).to have_content("Date of Order: #{@order_2.created_at}")
      end
      within "#order-#{@order_3.id}" do
        expect(page).to have_link(@order_1.user, href: admin_user_path(@order_3.user))
        expect(page).to have_content("Order ID: #{@order_3.id}")
        expect(page).to have_content("Date of Order: #{@order_3.created_at}")
      end
      within "#order-#{@order_4.id}" do
        expect(page).to have_link(@order_1.user, href: admin_user_path(@order_4.user))
        expect(page).to have_content("Order ID: #{@order_4.id}")
        expect(page).to have_content("Date of Order: #{@order_4.created_at}")
      end

      expect(page.all(".orders")[0]).to have_content("#{@order_2.id}")
      expect(page.all(".orders")[1]).to have_content("#{@order_1.id}")
      expect(page.all(".orders")[2]).to have_content("#{@order_3.id}")
      expect(page.all(".orders")[3]).to have_content("#{@order_4.id}")
    end
  end
end
