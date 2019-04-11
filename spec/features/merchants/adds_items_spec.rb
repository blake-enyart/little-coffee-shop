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
      fill_in "Image url",	with: "#{@item_3.image_url}" 
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
      fill_in "Image url",	with: "#{@item_3.image_url}" 
      fill_in "Quantity",	with: "#{@item_3.quantity}" 
      fill_in "Price",	with: 0.00

      click_button "Add Item"

      expect(page).to have_content("Price must be greater than 0.0")
    end

    it 'new item quantity must be greater than zero' do
      fill_in "Name",	with: "#{@item_3.name}" 
      fill_in "Description",	with: "#{@item_3.description}" 
      fill_in "Image url",	with: "#{@item_3.image_url}" 
      fill_in "Quantity",	with: 0
      fill_in "Price",	with: "#{@item_3.price}" 

      click_button "Add Item"

      expect(page).to have_content("Quantity must be greater than 0")
    end

    it 'new item image can be left blank must' do
      fill_in "Name",	with: "Item Test" 
      fill_in "Description",	with: "Item description" 
      fill_in "Image url",	with: nil 
      fill_in "Quantity",	with: 100 
      fill_in "Price",	with: 1.00

      click_button "Add Item"

      item = Item.last

      expect(page).to have_content("Item Test is now saved and available for sale.")
      
      expect(page).to have_css("img[src*='#{item.image_url}']")
#       expect(item.image_url).to eq("https://i.pinimg.com/originals/2a/84/90/2a849069c7f487f71bb6594dffb84e5e.png")
    end

    it 'new item must have price' do
      fill_in "Name",	with: "#{@item_3.name}" 
      fill_in "Description",	with: "#{@item_3.description}" 
      fill_in "Image url",	with: "#{@item_3.image_url}" 
      fill_in "Quantity",	with: "#{@item_3.quantity}" 
      fill_in "Price",	with: nil 
      click_button "Add Item"
      
      expect(page).to have_content("Price is not a number")
      expect(page).to have_content("Price can't be blank")
    end

    it 'new item must have quantity' do
      fill_in "Name",	with: "#{@item_3.name}" 
      fill_in "Description",	with: "#{@item_3.description}" 
      fill_in "Image url",	with: "#{@item_3.image_url}" 
      fill_in "Quantity",	with: nil
      fill_in "Price",	with: "#{@item_3.price}" 
      
      click_button "Add Item"

      expect(page).to have_content("Quantity is not a number")
      expect(page).to have_content("Quantity can't be blank")
      expect(find_field('Name').value).to eq(@item_3.name)
    end

    it 'new item must have name' do
      fill_in "Name",	with: nil 
      fill_in "Description",	with: "#{@item_3.description}" 
      fill_in "Image url",	with: "#{@item_3.image_url}" 
      fill_in "Quantity",	with: "#{@item_3.quantity}" 
      fill_in "Price",	with: "#{@item_3.price}" 

      click_button "Add Item"

      expect(page).to have_content("Name can't be blank")
      expect(find_field('Price').value).to eq("#{@item_3.price}")
    end

    it 'new item must have description' do
      fill_in "Name",	with: "#{@item_3.description}"
      fill_in "Description",	with: nil 
      fill_in "Image url",	with: "#{@item_3.image_url}" 
      fill_in "Quantity",	with: "#{@item_3.quantity}" 
      fill_in "Price",	with: "#{@item_3.price}" 

      click_button "Add Item"

      expect(page).to have_content("Description can't be blank")
      expect(find_field('Price').value).to eq("#{@item_3.price}")
    end
  end
end
