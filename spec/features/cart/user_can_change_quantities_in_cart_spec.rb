require 'rails_helper'

RSpec.describe 'User can manipulate quantities in their cart', type: :feature do
  context 'As a visitor or registered user with items in my cart' do
    before :each do
      @item_1 = create(:item, quantity: 1)
      @item_2 = create(:item, quantity: 10)
      visit item_path(@item_1) # Add one item_1 to cart
      click_on "Add to Cart"

      visit item_path(@item_2) # Add two item_2s to cart
      click_on "Add to Cart"
      visit item_path(@item_2)
      click_on "Add to Cart"

      visit cart_path
    end

    scenario 'I can remove an item from my cart' do
      expect(page).to have_content(@item_1.name)

      within "#cart-item-#{@item_1.id}" do
        expect(page).to have_content("Quantity: 1")
        click_on "Remove"
      end

      expect(current_path).to eq(cart_path)
      expect(page).to_not have_content(@item_1.name)

      expect(page).to have_content(@item_2.name)

      within "#cart-item-#{@item_2.id}" do
        expect(page).to have_content("Quantity: 2")
        click_on "Remove"
      end

      expect(page).to_not have_content(@item_2.name)
    end

    scenario 'I can increment the count of items I want to purchase' do
      within "#cart-item-#{@item_2.id}" do
        expect(page).to have_content("Quantity: 2")
        click_on "+"
        expect(page).to have_content("Quantity: 3")
      end
    end

    it 'does not allow me to increment the count beyond the merchants inventory' do
      within "#cart-item-#{@item_1.id}" do
        expect(page).to have_content("Quantity: 1")
        click_on "+"
        expect(page).to have_content("Quantity: 1") # Because we created item_1 with quantity: 1 in the before :each
      end
      expect(page).to have_content("You have reached the maximum stock available currently for #{@item_1.name}.")
    end

    scenario 'I can decrement the count of items I want to purchase' do
      within "#cart-item-#{@item_2.id}" do
        expect(page).to have_content("Quantity: 2")
        click_on "-"
        expect(page).to have_content("Quantity: 1")
      end
    end

    it 'removes the item from my cart if I decrement the count to zero' do
      within "#cart-item-#{@item_2.id}" do
        expect(page).to have_content("Quantity: 2")
        click_on "-"
        expect(page).to have_content("Quantity: 1")
        click_on "-"
      end

      expect(page).to_not have_content(@item_2.name) # because the item was decremented to 0
    end
  end
end
