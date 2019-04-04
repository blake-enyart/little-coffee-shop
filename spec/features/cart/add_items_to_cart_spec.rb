require 'rails_helper'

RSpec.describe 'User adding an item to the cart', type: :feature do
  context 'As a visitor or registered user viewing an item show page' do
    before :each do
      @item = create(:item)
      visit item_path(@item)
    end

    it 'show a message after I add this item to my cart' do
      click_on "Add to Cart"

      expect(current_path).to eq(items_path)
      expect(page).to have_content("You now have 1 copy of #{@item.name} in your cart.")
    end

    it 'correctly increments for multiple items in my cart' do
      click_on "Add to Cart"
      visit item_path(@item)
      click_on "Add to Cart"

      expect(page).to have_content("You now have 2 copies of #{@item.name} in your cart.")
    end

    it 'shows the total number of items in the cart' do
      expect(page).to have_content("Cart: 0")

      click_on "Add to Cart"

      expect(page).to have_content("Cart: 1")

      visit item_path(@item)
      click_on "Add to Cart"

      expect(page).to have_content("Cart: 2")
    end
  end
end
