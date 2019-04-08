require 'rails_helper'

RSpec.describe 'Registered users can check out', type: :feature do
  context 'As a logged in user with items in my cart and I visit my cart' do
    before :each do
      @user = create(:user)
      @item_1 = create(:item)
      @item_2 = create(:item)

      visit root_path

      click_link "Login"
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      click_button "Log In"

      visit item_path(@item_1) # Add one item_1 to cart
      click_on "Add to Cart"

      visit item_path(@item_2) # Add two item_2s to cart
      click_on "Add to Cart"
      visit item_path(@item_2)
      click_on "Add to Cart"

      visit cart_path
    end

    it 'shows a button or link indicating that I can check out' do
      expect(page).to have_link("Checkout", href: checkout_path)
    end

    scenario 'I click checkout and an order is created in the system, which has a status of pending' do
      click_on "Checkout"

      order = Order.last
      expect(order.user).to eq(@user)
      expect(order.status).to eq('pending')
    end

    scenario 'I click checkout and I am redirected to my orders page' do
      click_on "Checkout"

      expect(current_path).to eq("/profile/orders")
    end

    scenario 'I click checkout and I see a flash message telling me my order was created' do
      click_on "Checkout"

      expect(page).to have_content("Your order was created successfully.")
    end

    scenario 'I click checkout and I see my new order listed on my profile orders page' do
      click_on "Checkout"
      order = Order.last

      expect(page).to have_content("Order ID: #{order.id}")
    end

    scenario 'I click checkout and my cart is now empty' do
      expect(page).to have_content("Cart: 3")

      click_on "Checkout"

      expect(page).to have_content("Cart: 0")
    end
  end
end
