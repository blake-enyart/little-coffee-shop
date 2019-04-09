require 'rails_helper'

RSpec.describe 'Merchant Items Index Page', type: :feature do
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

    scenario 'dashboard_items_path takes me to /dashboard/items' do
      expect(current_path).to eq("/dashboard/items")
    end

    it 'shows a link to add a new item to the system' do
      expect(page).to have_link("Add New Item")
    end

    it 'shows each item I already have added to the system' do
      within "#merchant-item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.id)
        expect(page).to have_content(@item_1.name)
        expect(page).to have_css("img[src*='#{@item_1.image_url}']")
        expect(page).to have_content("Price: $#{@item_1.price}")
        expect(page).to have_content("Inventory: #{@item_1.quantity}")
      end

      within "#merchant-item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.id)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_css("img[src*='#{@item_2.image_url}']")
        expect(page).to have_content("$#{@item_2.price}")
        expect(page).to have_content("Inventory: #{@item_2.quantity}")
      end
    end

    it 'shows links to edit each item' do
      within "#merchant-item-#{@item_1.id}" do
        expect(page).to have_link("Edit this item", href: edit_item_path(@item_1))
      end

      within "#merchant-item-#{@item_2.id}" do
        expect(page).to have_link("Edit this item", href: edit_item_path(@item_2))
      end
    end

    it 'shows links to delete items that were never ordered' do
      within "#merchant-item-#{@item_1.id}" do
        expect(page).to have_link("Delete Item")
      end

      within "#merchant-item-#{@item_2.id}" do
        expect(page).to_not have_link("Delete Item") # Because that item has been ordered before
      end
    end

    it 'shows link to disable items that are enabled' do
      within "#merchant-item-#{@item_1.id}" do
        expect(page).to have_link("Disable")
      end

      within "#merchant-item-#{@inactive_item.id}" do
        expect(page).to_not have_link("Disable")
      end
    end

    it 'shows link to enable items that are disabled' do
      within "#merchant-item-#{@inactive_item.id}" do
        expect(page).to have_link("Enable")
      end

      within "#merchant-item-#{@item_1.id}" do
        expect(page).to_not have_link("Enable")
      end
    end
  end
end
