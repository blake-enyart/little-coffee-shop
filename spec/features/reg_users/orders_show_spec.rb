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
      expect(page).to have_link("My Orders", href: orders_path)
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
      expect(page).to_not have_link("My Orders", href: orders_path)
    end
  end
end
