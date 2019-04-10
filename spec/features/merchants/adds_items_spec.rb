require 'rails_helper'

RSpec.describe 'Merchant Items Index Page', type: :feature do
  context 'as a merchant with items, I view my items page' do
    before :each do
      @merchant = create(:merchant)
      @item_1 = create(:item, user: @merchant)
      @item_2 = create(:item, user: @merchant)
      @item_3 = build(:item, image_url: nil)
      @inactive_item = create(:inactive_item, user: @merchant)
      create(:order_item, item: @item_2)
      
      visit root_path

      click_link "Login"
      fill_in "email", with: @merchant.email
      fill_in "password", with: @merchant.password
      click_button "Log In"

      visit dashboard_items_path

      click_link "Add New Item"
    end

    it 'can add new item' do
      fill_in "Name",	with: "#{@item_3.name}" 
      fill_in "Description",	with: "#{@item_3.description}" 
      fill_in "Image Url",	with: "#{@item_3.image_url}" 
      fill_in "Quantity",	with: "#{@item_3.quantity}" 
      fill_in "Price",	with: "#{@item_3.price}"
      click_button "Add Item"

      new_item = Item.last

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("#{new_item.name} is now saved and available for sale.")
    end

    it 'new item price must be greater than zero' do
      
      fill_in "Name",	with: "#{@item_3.name}" 
      fill_in "Description",	with: "#{@item_3.description}" 
      fill_in "Image Url",	with: "#{@item_3.image_url}" 
      fill_in "Quantity",	with: "#{@item_3.quantity}" 
      fill_in "Price",	with: 0.00
      click_button "Add Item"

      expect(page).to have_content("Price must be greater than 0.0")
    end

    it 'new item quantity must be greater than zero' do

      fill_in "Name",	with: "#{@item_3.name}" 
      fill_in "Description",	with: "#{@item_3.description}" 
      fill_in "Image Url",	with: "#{@item_3.image_url}" 
      fill_in "Quantity",	with: 0
      fill_in "Price",	with: "#{@item_3.price}" 
      click_button "Add Item"

      expect(page).to have_content("Quantity must be greater than 0")
    end

    it 'new item image can be left blank must' do

      fill_in "Name",	with: "Item Test" 
      fill_in "Description",	with: "Item description" 
      fill_in "Image Url",	with: nil 
      fill_in "Quantity",	with: 100 
      fill_in "Price",	with: 1.00
      click_button "Add Item"
      item = Item.last

      expect(page).to have_content("Item Test is now saved and available for sale.")
      
      expect(item.image_url).to eq("https://i.pinimg.com/originals/2a/84/90/2a849069c7f487f71bb6594dffb84e5e.png")
    end
  end
end