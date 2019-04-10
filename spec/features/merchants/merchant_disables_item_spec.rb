require 'rails_helper'

RSpec.describe 'Merchant disabling their item', type: :feature do
  context 'as a merchant with items, I view my items page' do
    before :each do
      @merchant = create(:merchant)
      @item_1 = create(:item, user: @merchant)
      @item_2 = create(:item, user: @merchant)
      @inactive_item = create(:inactive_item, user: @merchant)
      create(:order_item, item: @item_2)

      visit root_path

      click_link "Login"
      fill_in "email", with: @merchant.email
      fill_in "password", with: @merchant.password
      click_button "Log In"

      visit dashboard_items_path
    end

    scenario 'clicking an item disable link disables the item' do
      expect(@item_1.enabled).to eq(true)

      within "#merchant-item-#{@item_1.id}" do
        click_on "Disable"
      end

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("#{@item_1.name} is no longer for sale.")

      @item_1.reload
      expect(@item_1.enabled).to eq(false)

      within "#merchant-item-#{@item_1.id}" do
        expect(page).to have_link("Enable")
      end
    end
  end
end
