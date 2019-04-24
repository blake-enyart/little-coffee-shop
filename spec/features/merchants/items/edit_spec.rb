require 'rails_helper'

RSpec.describe 'Merchant edits an item', type: :feature do
  context 'as a logged in merchant' do
    before :each do
      @merchant = create(:merchant)
      @item = create(:item, user: @merchant)

      visit root_path
      click_link "Login"
      fill_in "email", with: @merchant.email
      fill_in "password", with: @merchant.password
      click_button "Log In"

      visit dashboard_items_path
    end

    it 'I can edit my item' do
      within "#merchant-item-#{@item.id}" do
        click_link "Edit this item"
      end

      expect(current_path).to eq("/dashboard/items/#{@item.id}/edit")
      expect(page).to have_field("Name", with: @item.name)
      expect(page).to have_field("Description", with: @item.description)
      expect(page).to have_field("Image url", with: @item.image_url)
      expect(page).to have_field("Quantity", with: @item.quantity)
      expect(page).to have_field("Price", with: @item.price)

      new_item_name = "New Item Name"

      fill_in "Name",	with: new_item_name
      click_on "Save Changes"

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("Item updated successfully.")

      within "#merchant-item-#{@item.id}" do
        expect(page).to have_content(new_item_name)
      end
    end

    describe 'Sad path, it shows error messages if edits fail validations' do
      before :each do
        within "#merchant-item-#{@item.id}" do
          click_link "Edit this item"
        end
      end

      it 'does not allow name to be blank' do
        fill_in "Name",	with: ""
        click_on "Save Changes"

        expect(current_path).to eq("/dashboard/items/#{@item.id}/edit")
        expect(page).to have_content("Name can't be blank")
      end

      it 'does not allow the description to be blank' do
        fill_in "Description",	with: ""
        click_on "Save Changes"

        expect(page).to have_content("Description can't be blank")
      end

      it 'does not allow price to be less than zero' do
        fill_in "Price",	with: -1
        click_on "Save Changes"

        expect(page).to have_content("Price must be greater than 0")
      end

      it 'does not allow inventory to be less than zero' do
        fill_in "Quantity",	with: -1
        click_on "Save Changes"

        expect(page).to have_content("Quantity must be greater than 0")
      end

      it 'adds a default image_url if I left the image field blank' do
        fill_in "Image url",	with: ""
        click_on "Save Changes"

        default_image = "https://i.pinimg.com/originals/2a/84/90/2a849069c7f487f71bb6594dffb84e5e.png"
        within "#merchant-item-#{@item.id}" do
          expect(page).to have_css("img[src*='#{default_image}']")
        end
      end
    end
  end
end
