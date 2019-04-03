require 'rails_helper'

RSpec.describe 'navigation bar' do
  context ' as a visitor' do
    it 'shows all the links' do
      visit root_path

      click_link "Items"
      expect(current_path).to eq(items_path)

      click_link "Merchants"
      expect(current_path).to eq(merchants_path)

      click_link "Cart"
      expect(current_path).to eq(cart_path)

      click_link "Login"
      expect(current_path).to eq(login_path)

      click_link "Register"
      expect(current_path).to eq(new_user_path)

      click_link "Home"
      expect(current_path).to eq(root_path)
    end
  end
  context ' as a registered user' do
    it 'shows all the links' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      click_link "Items"
      expect(current_path).to eq(items_path)

      click_link "Merchants"
      expect(current_path).to eq(merchants_path)

      click_link "Cart"
      expect(current_path).to eq(cart_path)

      click_link "Home"
      expect(current_path).to eq(root_path)

      click_link "Profile"
      expect(current_path).to eq(profile_path)
      expect(page).to_not have_link("Login", href: login_path)
      expect(page).to_not have_link("Register", href: new_user_path)
      expect(page).to have_content("Logged in as #{user.name}")

      click_link "Logout"
      expect(current_path).to eq(root_path)
      expect(page).to_not have_content("Logged in as #{user.name}")
    end
  end
  context ' as a merchant' do
    it 'shows all the links' do
      merchant = create(:merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit root_path

      click_link "Items"
      expect(current_path).to eq(items_path)

      click_link "Merchants"
      expect(current_path).to eq(merchants_path)

      click_link "Home"
      expect(current_path).to eq(root_path)

      click_link "Dashboard"
      expect(current_path).to eq(profile_path)
      expect(page).to_not have_link("Login", href: login_path)
      expect(page).to_not have_link("Register", href: new_user_path)
      expect(page).to_not have_content("Logged in as #{user.name}")

      click_link "Logout"
      expect(current_path).to eq(root_path)
      expect(page).to_not have_content("Logged in as #{user.name}")
    end
  end
end
