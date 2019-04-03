require 'rails_helper'

RSpec.describe 'Items Index Page', type: :feature do
  before :each do
    @item_1 = create(:item)
    @item_2 = create(:item)
    @inactive_item = create(:inactive_item)

    visit items_path
  end

  context 'as an unregistered user' do
    it 'shows all items in the system except disabled items' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)

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

  context 'as a registered user' do
    it 'shows all items in the system except disabled items' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

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

  context 'as a merchant' do
    it 'shows all items in the system except disabled items' do
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

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

  context 'as an admin' do
    it 'shows all items in the system except disabled items' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

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
