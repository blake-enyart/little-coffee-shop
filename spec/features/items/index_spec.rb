require 'rails_helper'

RSpec.describe 'Items Index Page', type: :feature do
  before :each do
    @item_1 = create(:item)
    @item_2 = create(:item)
    @inactive_item = create(:inactive_item)

    visit items_path
  end

  context 'as any kind of user on the system' do
    it 'shows all items in the system except disabled items' do
      within "#item-#{@item_1.id}" do
        expect(page).to have_link(@item_1.name, href: item_path(@item_1))
        expect(page).to have_css("img[src*='#{@item_1.image_url}']")
        expect(page).to have_content(@item_1.user.name)
        expect(page).to have_content("In stock: #{@item_1.quantity}")
        expect(page).to have_content("$#{@item_1.price.round(2)}")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_link(@item_2.name, href: item_path(@item_2))
        expect(page).to have_css("img[src*='#{@item_2.image_url}']")
        expect(page).to have_content(@item_2.user.name)
        expect(page).to have_content("In stock: #{@item_2.quantity}")
        expect(page).to have_content("$#{@item_2.price.round(2)}")
      end

      expect(page).to_not have_link(@inactive_item.name, href: item_path(@inactive_item))
      expect(page).to_not have_css("img[src*='#{@inactive_item.image_url}']")
      expect(page).to_not have_content(@inactive_item.user.name)
      expect(page).to_not have_content("In stock: #{@inactive_item.quantity}")
      expect(page).to_not have_content("$#{@inactive_item.price.round(2)}")
    end
  end
end
