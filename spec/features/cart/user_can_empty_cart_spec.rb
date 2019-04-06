require 'rails_helper'

RSpec.describe 'User can empty a cart that has items', type: :feature do
  context 'as a visitor or registered user with items in my cart' do
    it 'lets me empty my cart' do
      item_1 = create(:item)
      item_2 = create(:item)

      visit item_path(item_1) # Add one item_1 to cart
      click_on "Add to Cart"

      visit item_path(item_2) # Add two item_2s to cart
      click_on "Add to Cart"
      visit item_path(item_2)
      click_on "Add to Cart"

      visit cart_path

      expect(page).to have_content("Cart: 3")

      click_link "Empty Cart"

      expect(current_path).to eq(cart_path)
      expect(page).to have_content("Cart: 0")
      expect(page).to have_content("Your cart is empty.")
      expect(page).to_not have_link("Empty Cart")
    end
  end
end
