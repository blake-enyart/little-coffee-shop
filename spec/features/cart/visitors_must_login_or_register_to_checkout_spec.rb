require 'rails_helper'

RSpec.describe 'Visitors must register or log in to check out', type: :feature do
  context 'As a visitor with items in my cart and I visit my cart' do
    before :each do
      item_1 = create(:item)
      item_2 = create(:item)

      visit item_path(item_1) # Add one item_1 to cart
      click_on "Add to Cart"

      visit item_path(item_2) # Add two item_2s to cart
      click_on "Add to Cart"
      visit item_path(item_2)
      click_on "Add to Cart"

      visit cart_path
    end

    it 'tells me I must register or log in to finish the checkout process' do
      within "#register-or-login-to-checkout" do
        expect(page).to have_content("You must Register or Login to checkout.")
      end
    end

    it 'shows the word "register" as a link to the registration page' do
      within "#register-or-login-to-checkout" do
        expect(page).to have_link("Register", href: new_user_path)
      end
    end

    it 'shows words "log in" as a link to the login page' do
      within "#register-or-login-to-checkout" do
        expect(page).to have_link("Login", href: login_path)
      end
    end
  end
end
