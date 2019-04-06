require 'rails_helper'

RSpec.describe 'User views their cart show page with items in the cart', type: :feature do
  context 'as an unregistered visitor with items in my cart and I view my cart' do
    it 'shows cart information' do
      item_1 = create(:item)
      item_2 = create(:item)

      visit item_path(item_1) # Add one item_1 to cart
      click_on "Add to Cart"

      visit item_path(item_2) # Add two item_2s to cart
      click_on "Add to Cart"
      visit item_path(item_2)
      click_on "Add to Cart"

      visit cart_path

      within "#cart-item-#{item_1.id}" do
        expect(page).to have_content(item_1.name)
        expect(page).to have_css("img[src*='#{item_1.image_url}']")
        expect(page).to have_content(item_1.user.name)
        expect(page).to have_content("$#{item_1.price}")
        expect(page).to have_content("Subtotal: #{item_1.price}")
      end

      within "#cart-item-#{item_2.id}" do
        expect(page).to have_content(item_2.name)
        expect(page).to have_css("img[src*='#{item_2.image_url}']")
        expect(page).to have_content(item_2.user.name)
        expect(page).to have_content("$#{item_2.price}")
        expect(page).to have_content("Subtotal: #{item_2.price * 2}")
      end

      expect(page).to have_content("Grand Total: $#{item_1.price + item_2.price * 2}")
    end
  end
end
