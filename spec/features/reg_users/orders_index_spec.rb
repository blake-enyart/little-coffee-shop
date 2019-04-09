require 'rails_helper'

RSpec.describe 'User Order Show Page' do
  context 'as a registered user, with orders in the system, viewing my profile' do
    before(:each) do
      @user = create(:user)
      @order_1 = create(:order, user: @user)

      visit root_path

      click_link "Login"
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      click_button "Log In"

      visit profile_path
    end

    it 'shows a link on my profile page called My Orders' do
      expect(page).to have_link("My Orders", href: profile_orders_path)
    end

    scenario 'clicking this link takes me to /profile/orders' do
      click_link "My Orders"

      expect(current_path).to eq("/profile/orders")
    end
  end

  context 'as a registered user, with ZERO orders in the system, viewing my profile' do
    it 'it does not show a link on my profile page called My Orders' do
      user = create(:user)

      visit root_path

      click_link "Login"
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_button "Log In"

      visit profile_path
      expect(page).to_not have_link("My Orders", href: profile_orders_path)
    end
  end

  context 'as a registered user, with orders in the system, viewing my profile/orders' do
    before(:each) do
      @user = create(:user)
      @order_1 = create(:order, user: @user)
      @order_2 = create(:order, user: @user)

      visit root_path

      click_link "Login"
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      click_button "Log In"

      visit profile_orders_path
    end

    it 'shows order info for all my orders' do
      within "#order-#{@order_1.id}" do
        expect(page).to have_content("Order ID: #{@order_1.id}")
        expect(page).to have_link(@order_1.id.to_s, href: profile_order_path(@order_1))
        expect(page).to have_content("Date of Order: #{@order_1.created_at}")
        expect(page).to have_content("Last Updated: #{@order_1.updated_at}")
        expect(page).to have_content("Status: #{@order_1.status}")
        expect(page).to have_content("$#{@order_1.grand_total}")
      end

      within "#order-#{@order_2.id}" do
        expect(page).to have_content("Order ID: #{@order_2.id}")
        expect(page).to have_link(@order_2.id.to_s, href: profile_order_path(@order_2))
        expect(page).to have_content("Date of Order: #{@order_2.created_at}")
        expect(page).to have_content("Last Updated: #{@order_2.updated_at}")
        expect(page).to have_content("Status: #{@order_2.status}")
        expect(page).to have_content("$#{@order_2.grand_total}")
      end
    end
  end
end
